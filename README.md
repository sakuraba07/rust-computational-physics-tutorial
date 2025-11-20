# rust-computational-physics-tutorial

rustでの計算物理学のドキュメント

## ビルド方法

### 必要なツール

このプロジェクトは[mise](https://mise.jdx.dev/)を使用してツールを管理しています。

```bash
# miseのインストール（まだの場合）
curl https://mise.run | sh

# 必要なツールのインストール
mise install
```

### ビルド

```bash
# mdBookのビルドとpagefind検索インデックスの生成
mise run build
```

このコマンドは以下を実行します：

1. `mdbook build` - mdBookをビルド
2. `pagefind --site book` - 検索インデックスを生成
3. `lychee book/` - リンクチェック

### ローカルプレビュー

```bash
# 開発サーバーを起動（ポート3000）
mdbook serve --open
```

または、ビルド済みのファイルを確認する場合：

```bash
# 簡易HTTPサーバーを起動
python3 -m http.server 8000 --directory book
```

ブラウザで `http://localhost:8000` を開いてください。

## 検索機能について

このプロジェクトは[Pagefind](https://pagefind.app/)を使用した検索機能を実装しています。

### 使い方

- 検索アイコン（🔍）をクリックするか、`S`または`/`キーを押すと検索バーが表示されます
- 検索バーに検索キーワードを入力すると、リアルタイムで結果が表示されます
- `Esc`キーで検索バーを閉じることができます

### 技術詳細

- **検索エンジン**: Pagefind（Rust製の静的サイト検索）
- **言語**: 日本語対応
- **インデックス**: ビルド時に自動生成
- **UI**: PagefindのデフォルトUIをmdBookのテーマに統合

#### カスタマイズファイル

- `theme/index.hbs` - Pagefind統合のHTMLテンプレート
- `theme/css/pagefind.css` - Pagefind UIのカスタムスタイル
- `mise.toml` - ビルドタスクの設定

## クリーンビルド

```bash
# ビルド成果物を削除
mise run clean

# 再ビルド
mise run build
```
