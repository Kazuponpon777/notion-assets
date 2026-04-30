#!/bin/bash
# 🚀 Notion Assets Magic Uploader
# 使い方: bash upload.sh <画像ファイル名> <カテゴリー名(任意)>

if [ -z "$1" ]; then
    echo "❌ エラー: ファイルを指定してください。"
    echo "使い方: bash upload.sh my_image.png [category]"
    exit 1
fi

# カテゴリーフォルダの設定（デフォルトは misc）
CATEGORY=${2:-"misc"}
mkdir -p "$CATEGORY"

# ファイルのコピー
cp "$1" "$CATEGORY/"
FILENAME=$(basename "$1")

echo "📦 GitHubへアップロード中..."
git add .
git commit -m "Add asset: $FILENAME in $CATEGORY"
git push origin main

if [ $? -eq 0 ]; then
    echo "------------------------------------------------"
    echo "✅ アップロード成功！"
    echo "Notionに貼り付けるURLはこちらです："
    echo "https://raw.githubusercontent.com/Kazuponpon777/notion-assets/main/$CATEGORY/$FILENAME"
    echo "------------------------------------------------"
else
    echo "❌ プッシュに失敗しました。ネットワークを確認してください。"
fi
