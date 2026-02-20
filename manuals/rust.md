# direvn 導入

1. `home.nix` に下記を追記する
    ```nix
    # ディレクトリ開発環境設定
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    ```
    実例: [home.nix](../home.nix)
2. リビルドする
3. インストール出来たかを確認する
    ```shellsession
    $ direnv --version
    2.37.1
    ```

> [!NOTE]
> インストール完了後は再起動する。
> 自分の環境で `direnv allow` コマンドが動かなかったため。
> 仮想環境由来の現象かもしれない。

# プロジェクト環境作成

仮にプロジェクトのディレクトリを `~/projects/hello-world` とする。

1. プロジェクトディレクトリへ移動する
	```shellsession
	$ cd ~/projects/hello-world
	```
2. `flake.nix` ファイルを作成する
	```nix
	# プロジェクトのルートディレクトリに flake.nix として保存
	{
	  inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		utils.url = "github:numtide/flake-utils";
	  };
	
	  outputs = { self, nixpkgs, utils }:
		utils.lib.eachDefaultSystem (system:
		  let
			pkgs = import nixpkgs { inherit system; };
		  in
		  {
			devShells.default = pkgs.mkShell {
			  # ここにこのプロジェクトだけで使いたいツールを書く
			  buildInputs = with pkgs; [
				cargo
				rustc
				rust-analyzer
				rustfmt
				clippy
				
				# Cコンパイラと標準的なビルドツール
				gcc
				binutils
				gnumake
				
				# (例) もしOpenSSLが必要になったらここに追加するだけ
				# pkg-config
				# openssl
			  ];
	
			  shellHook = ''
				echo "Rust development environment loaded!"
				rustc --version
			  '';
			};
		  });
	}
	```
3. `.envrc` を作成する
	```nix
	# プロジェクトのルートディレクトリに .envrc として保存
	use flake
	```
    > [!NOTE]
    > ファイル作成時に下記のようなメッセージが表示されるかもしれない。
    > 次の手順で実行するため無視で良い。
    > `direnv: error /home/user/projects/hello-world/.envrc is blocked. Run \`direnv allow\` to approve its content`
4. 環境構築を実行する
	```shellsession
	$ direnv allow
	```
	`Rust development environment loaded!` が表示されれば完了。
5. このディレクトリだけで rust が有効化されているか確認する
	```shellsession
	$ which rustc
	/nix/store/qvpg842zrjkywv7sqgw2h05spdyzcj86-rustc-wrapper-1.92.0/bin/rustc
	```
	```shellsession
	$ cd ../
	direnv: unloading
	```
	```shellsession
	$ which rustc
	rustc not found
	```
	親ディレクトリへ抜けたことで rust が無効化されたことが分かる。

# テスト

1. プロジェクトディレクトリへ移動する
	```shellsession
	$ cd ~/projects/hello-world
	```
2. プロジェクトを作成する
	```shellsession
	$ cargo init
	    Creating binary (application) package
	note: see more `Cargo.toml` keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html
	```
3. プロジェクトを実行する
	```shellsession
	$ cargo run
	   Compiling hello-world v0.1.0 (/home/user/projects/hello-world)
	    Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.36s
	     Running `target/debug/hello-world`
	Hello, world!
	```

# flake / Cargo の使い分け

一見、同じ役割のファイルが存在するように見える。

```shellsession
$ ls
Cargo.lock  Cargo.toml  flake.lock  flake.nix  src  target
```

+ `flake.nix`, `flake.lock`
+ `Cargo.toml`, `Cargo.lock`

下記の表にあるように用途が違う。

|**比較項目**|**Nix Flake (flake.nix / .lock)**|**Cargo (Cargo.toml / .lock)**|
|---|---|---|
|**管理対象**|**ツール・言語・システムライブラリ**|**Rustのクレート（ライブラリ）**|
|**具体例**|`rustc`, `gcc`, `openssl`, `zlib`|`serde`, `tokio`, `rand`|
|**役割**|コンパイルできる「環境」を固定する|プログラムが使う「部品」を固定する|
|**再現性**|どのPCでも同じ環境を再現|どのRust環境でも同じバイナリを再現|