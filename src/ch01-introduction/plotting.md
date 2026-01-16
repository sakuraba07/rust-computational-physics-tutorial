# 数値計算結果の可視化

数値計算を実行する上で、その結果を視覚的に検証するプロセスは非常に重要です。グラフやアニメーションといった可視化手法は、計算の正当性を検証し、物理現象の動的な振る舞いを直感的に理解するための強力な手段となります。

本節では、数値計算結果を可視化するためのいくつかの手法を紹介します。

## 可視化ツールの選択

本書では、開発環境をRustで統一する観点から`plotters`や`three-d`といったRust製ライブラリを用いますが、読者の皆様はご自身が使い慣れたツールを自由にご利用いただけます。

可視化は、本書で解説する数値計算アルゴリズム自体とは独立した、計算結果を理解・分析するための補助的な手段です。Python (`matplotlib`)、`gnuplot`、Excel、MATLAB、Mathematicaなど、既に習熟されているツールがあれば、そちらの利用を推奨します。

本書のコード例から`plotters`や`three-d`に関する部分を省略し、計算結果をCSVファイルに出力した上で、任意のツールで可視化するというアプローチを採っていただいても全く問題ありません。

## データファイルへの出力

どのような可視化ツールを利用するにせよ、計算結果をファイルに保存する方法を習得しておくことは有益です。特に、CSV (Comma-Separated Values) 形式は多くのツールでサポートされており、汎用性が高いため本書でも推奨します。もちろん、大量のデータを効率的に扱いたい場合など、用途によってはHDF5やApache Parquetといった、より高機能なフォーマットを利用することも有効です。

### CSVファイルへの出力

CSVファイルは非常に汎用的なデータ形式であり、ほぼすべての可視化ツールや表計算ソフトで読み込むことが可能です。

```rust
use std::fs::File;
use std::io::Write;

fn main() -> std::io::Result<()> {
    let mut file = File::create("output.csv")?;

    // ヘッダー行を書き込む
    writeln!(file, "t,x,v")?;

    // 0.0から10.0まで0.1刻みでデータを生成して書き込む
    for i in 0..=100 {
        let t = i as f64 * 0.1;
        let x = t.sin();
        let v = t.cos();
        writeln!(file, "{},{},{}", t, x, v)?;
    }

    println!("output.csv を生成しました");
    Ok(())
}
```

このCSVファイルは、以下のような様々なツールで可視化できます。

### Pythonによる可視化例

```python
import japanize_matplotlib  # noqa
import pandas as pd
import matplotlib.pyplot as plt

# CSVファイルの読み込み
df = pd.read_csv("output.csv")

# グラフの描画
plt.figure(figsize=(10, 6))
plt.plot(df["t"], df["x"], label="位置 x")
plt.plot(df["t"], df["v"], label="速度 v")
plt.xlabel("時間 t")
plt.ylabel("値")
plt.legend()
plt.grid(True)
plt.savefig("plot.png")
plt.show()
```

### gnuplotによる可視化例

```gnuplot
set datafile separator ","
set xlabel "時間 t"
set ylabel "値"
set grid
plot "output.csv" using 1:2 with lines title "位置 x", \
     "output.csv" using 1:3 with lines title "速度 v"
```

### Excelによる可視化

CSVファイルをExcelで開き、データ範囲を選択して「挿入」タブからグラフを作成するだけで、簡単に可視化できます。

---

## Rust製ライブラリによる可視化

以下では、本書で利用するRust製の可視化ライブラリについて解説します。**これらのライブラリを使用せず、前述のCSVファイル出力と外部ツールを組み合わせる方法でも、本書の学習を進めることは可能です。**

### plotters (2Dグラフ描画)

[plotters](https://crates.io/crates/plotters)は、Rustで最も広く利用されている2Dプロットライブラリの一つです。

**主な特徴:**

- 折れ線グラフ、散布図、ヒストグラム、ヒートマップなど多彩なグラフ形式をサポート
- PNG, SVG, HTMLなど複数の出力形式に対応
- 純粋なRustで実装されており、外部ライブラリへの依存が最小限
- 高いカスタマイズ性

### three-d (3D可視化)

[three-d](https://crates.io/crates/three-d)は、2Dおよび3Dグラフィックス向けの柔軟で高機能なレンダリングライブラリです。

**主な特徴:**

- 最新のグラフィックスAPI（Windows/LinuxではOpenGL、WebではWebGL2）をサポート
- 物理ベースレンダリング（PBR）、ライティング、シェーダーなどの高度な機能を提供
- `kiss3d`のようなシンプルなライブラリに比べ学習コストは高いですが、より詳細な制御と高い表現力が得られます。

## 可視化ライブラリの導入

これらのライブラリを使用するには、プロジェクトの`Cargo.toml`に依存関係として追加します。

### plottersの追加

`plotters`と共に、CSVファイルを読み込むための`csv`クレートも依存関係に追加します。

```toml:Cargo.toml
[dependencies]
plotters = "0.3"
csv = "1.4" # CSVファイルの読み込みに必要
```

### three-dの追加

```toml:Cargo.toml
[dependencies]
three-d = "0.18"
```

## plottersによる2Dグラフ描画

ここでは`plotters`を用いて、「データファイルへの出力」の項で作成した`output.csv`ファイルを読み込み、グラフを描画する方法を示します。

> [!NOTE]
> `plotters`で日本語のような非ASCII文字を表示するには、フォントファイルへのパスを正しく指定する必要があり、環境によっては追加のセットアップを要する場合があります。
> 本チュートリアルでは、追加設定なしでどの環境でもコードが動作することを優先するため、グラフ内のテキストには英語を使用します。

> [!NOTE]
> 以降のコードを実行する前に、`output.csv`が生成されていることを確認してください。未生成の場合は、「CSVファイルへの出力」の項に記載のコードを先に実行してください。

### CSVからのデータ読み込みと描画 (単一系列)

以下のコードは、`output.csv`ファイルを読み込み、`t`と`x`のデータを用いてグラフを描画し、`plot-single.png`というファイル名で保存します。

```rust,noplayground
use plotters::prelude::*;
use std::error::Error;

// 設定定数
const INPUT_CSV: &str = "output.csv";
const OUTPUT_IMAGE: &str = "plot-single.png";
const IMAGE_WIDTH: u32 = 800;
const IMAGE_HEIGHT: u32 = 600;

fn main() -> Result<(), Box<dyn Error>> {
    // 1. CSVファイルからデータを読み込む
    let mut reader = csv::Reader::from_path(INPUT_CSV)?;
    let data: Vec<(f64, f64)> = reader
        .records()
        .enumerate()
        .map(|(i, r)| {
            let record = r.map_err(|e| format!("行 {} の読み込みエラー: {e}", i + 1))?;
            let t: f64 = record
                .get(0)
                .ok_or_else(|| format!("行 {}: 時刻データが存在しません", i + 1))?
                .parse()
                .map_err(|e| format!("行 {} の時刻パースエラー: {e}", i + 1))?;
            let x: f64 = record
                .get(1)
                .ok_or_else(|| format!("行 {}: 位置データが存在しません", i + 1))?
                .parse()
                .map_err(|e| format!("行 {} の位置パースエラー: {e}", i + 1))?;
            Ok((t, x))
        })
        .collect::<Result<Vec<_>, String>>()?;

    // データが空の場合のチェック
    if data.is_empty() {
        return Err("CSVファイルにデータが含まれていません".into());
    }

    // 軸の範囲を自動計算
    let (t_min, t_max) = data
        .iter()
        .fold((f64::MAX, f64::MIN), |(min, max), (t, _)| {
            (min.min(*t), max.max(*t))
        });
    let (x_min, x_max) = data
        .iter()
        .fold((f64::MAX, f64::MIN), |(min, max), (_, x)| {
            (min.min(*x), max.max(*x))
        });

    // マージンを追加
    let t_margin = (t_max - t_min) * 0.05;
    let x_margin = (x_max - x_min) * 0.1;
    let t_range = (t_min - t_margin)..(t_max + t_margin);
    let x_range = (x_min - x_margin)..(x_max + x_margin);

    // 2. 描画バックエンドをセットアップする
    let root = BitMapBackend::new(OUTPUT_IMAGE, (IMAGE_WIDTH, IMAGE_HEIGHT)).into_drawing_area();
    root.fill(&WHITE)?;

    // 3. チャートを構築する
    let mut chart = ChartBuilder::on(&root)
        .caption("Position x vs. Time t (from CSV)", ("sans-serif", 30))
        .margin(20)
        .x_label_area_size(40)
        .y_label_area_size(40)
        .build_cartesian_2d(t_range, x_range)?;

    // 4. メッシュ (軸とグリッド線) を描画する
    chart
        .configure_mesh()
        .x_desc("Time t")
        .y_desc("Position x")
        .draw()?;

    // 5. データ系列 (t, x) を描画する
    chart.draw_series(LineSeries::new(data, &RED))?;

    // 6. ファイルに保存する
    root.present()?;
    println!("{OUTPUT_IMAGE} を生成しました");
    Ok(())
}
```

### コードの解説

`plotters`を用いてCSVデータからグラフを描画する手順は、概ね以下の通りです。

1. **データの読み込み**: `csv`クレートを利用して`output.csv`を読み込み、プロット対象のデータ（この場合は`t`と`x`）を`Vec<(f64, f64)>`のような形式に変換します。
2. **バックエンドの作成**: `BitMapBackend`（PNG出力用）など、描画先を指定します。
3. **チャートの構築**: `ChartBuilder`を用いて、描画範囲、タイトル、マージンなどの各種設定を行います。
4. **メッシュの描画**: `configure_mesh().draw()`を呼び出し、軸やグリッド線を描画します。
5. **データ系列の描画**: `draw_series`メソッドに`LineSeries`と描画データを渡し、プロットを実行します。
6. **ファイルへの保存**: `present()`メソッドにより、ここまでの描画内容をファイルに書き出します。

### 複数系列の描画

次に、`output.csv`に含まれる「位置 `x`」と「速度 `v`」の両方を一枚のグラフに描画します。

```rust,noplayground
use plotters::prelude::*;
use std::error::Error;

// 定数定義
const INPUT_CSV: &str = "output.csv";
const OUTPUT_IMAGE: &str = "plot-multi.png";
const IMAGE_WIDTH: u32 = 800;
const IMAGE_HEIGHT: u32 = 600;

// データポイント構造体
struct DataPoint {
    t: f64,
    x: f64,
    v: f64,
}

fn main() -> Result<(), Box<dyn Error>> {
    // CSVからデータを読み込み、構造化データとしてパース
    let mut reader = csv::Reader::from_path(INPUT_CSV)?;
    let data: Vec<DataPoint> = reader
        .records()
        .enumerate()
        .map(|(i, result)| {
            let record = result.map_err(|e| format!("行 {} の読み込みエラー: {e}", i + 2))?;
            Ok(DataPoint {
                t: record[0]
                    .parse()
                    .map_err(|e| format!("行 {} の時刻パースエラー: {e}", i + 2))?,
                x: record[1]
                    .parse()
                    .map_err(|e| format!("行 {} の位置パースエラー: {e}", i + 2))?,
                v: record[2]
                    .parse()
                    .map_err(|e| format!("行 {} の速度パースエラー: {e}", i + 2))?,
            })
        })
        .collect::<Result<Vec<_>, String>>()?;

    // 軸範囲の自動計算
    let (t_min, t_max) = data.iter().fold((f64::MAX, f64::MIN), |(min, max), d| {
        (min.min(d.t), max.max(d.t))
    });
    let (val_min, val_max) = data.iter().fold((f64::MAX, f64::MIN), |(min, max), d| {
        (min.min(d.x).min(d.v), max.max(d.x).max(d.v))
    });

    // マージンを追加
    let t_margin = (t_max - t_min) * 0.05;
    let val_margin = (val_max - val_min) * 0.1;
    let t_range = (t_min - t_margin)..(t_max + t_margin);
    let val_range = (val_min - val_margin)..(val_max + val_margin);

    let root = BitMapBackend::new(OUTPUT_IMAGE, (IMAGE_WIDTH, IMAGE_HEIGHT)).into_drawing_area();
    root.fill(&WHITE)?;

    let mut chart = ChartBuilder::on(&root)
        .caption("Position and Velocity (from CSV)", ("sans-serif", 30))
        .margin(20)
        .x_label_area_size(40)
        .y_label_area_size(40)
        .build_cartesian_2d(t_range, val_range)?;

    chart
        .configure_mesh()
        .x_desc("Time t")
        .y_desc("Value")
        .draw()?;

    // 位置 x のデータ系列
    let pos_series = LineSeries::new(data.iter().map(|d| (d.t, d.x)), &RED);

    // 速度 v のデータ系列
    let vel_series = LineSeries::new(data.iter().map(|d| (d.t, d.v)), &BLUE);

    // 系列を描画し、凡例を設定
    chart
        .draw_series(pos_series)?
        .label("Position x")
        .legend(|(x, y)| PathElement::new(vec![(x, y), (x + 20, y)], RED));

    chart
        .draw_series(vel_series)?
        .label("Velocity v")
        .legend(|(x, y)| PathElement::new(vec![(x, y), (x + 20, y)], BLUE));

    // 凡例の描画
    chart
        .configure_series_labels()
        .position(SeriesLabelPosition::UpperRight)
        .background_style(WHITE.mix(0.8))
        .border_style(BLACK)
        .draw()?;

    root.present()?;
    println!("{OUTPUT_IMAGE} を生成しました");
    Ok(())
}
```

このコードを実行すると、`plot-multi.png`というファイルに以下のようなグラフが描画されます。赤色の線が位置 `x`、青色の線が速度 `v` を表しており、凡例も表示されていることが確認できます。

![複数系列のプロット結果](../images/ch01/plot-multi.avif)

## three-dによる3D可視化

### 基本的な使い方

以下のコードは、回転する立方体を描画するウィンドウを表示します。

```rust,noplayground
use three_d::{
    AmbientLight, Camera, ClearState, CpuMaterial, CpuMesh, DirectionalLight, FrameOutput, Gm,
    Mat4, Mesh, OrbitControl, PhysicalMaterial, Srgba, Window, WindowSettings, degrees, radians,
    vec3,
};

// ウィンドウ設定
const WINDOW_TITLE: &str = "three-d: Cube";
const WINDOW_MAX_SIZE: (u32, u32) = (1280, 720);

// カメラ設定
const CAMERA_POSITION: (f32, f32, f32) = (0.0, 2.0, 4.0);
const CAMERA_TARGET: (f32, f32, f32) = (0.0, 0.0, 0.0);
const CAMERA_UP: (f32, f32, f32) = (0.0, 1.0, 0.0);
const CAMERA_FOV_DEGREES: f32 = 45.0;
const CAMERA_NEAR: f32 = 0.1;
const CAMERA_FAR: f32 = 100.0;

// カメラコントロール設定
const ORBIT_MIN_DISTANCE: f32 = 1.0;
const ORBIT_MAX_DISTANCE: f32 = 10.0;

// 立方体の色 (RGBA: 青色)
const CUBE_COLOR: Srgba = Srgba::new(0, 128, 255, 255);

// 光源設定
const DIRECTIONAL_LIGHT_INTENSITY: f32 = 2.0;
const DIRECTIONAL_LIGHT_DIRECTION: (f32, f32, f32) = (0.0, -1.0, -1.0);
const AMBIENT_LIGHT_INTENSITY: f32 = 0.4;

// 回転速度 (ラジアン/秒)
const ROTATION_SPEED: f32 = 1.0;

// 背景色 (RGBA)
const BACKGROUND_COLOR: (f32, f32, f32, f32) = (0.1, 0.1, 0.1, 1.0);

fn main() {
    // ウィンドウの作成
    let window = Window::new(WindowSettings {
        title: WINDOW_TITLE.to_string(),
        max_size: Some(WINDOW_MAX_SIZE),
        ..Default::default()
    })
    .expect("ウィンドウの作成に失敗しました");

    let context = window.gl();

    // カメラの設定
    let mut camera = Camera::new_perspective(
        window.viewport(),
        vec3(CAMERA_POSITION.0, CAMERA_POSITION.1, CAMERA_POSITION.2),
        vec3(CAMERA_TARGET.0, CAMERA_TARGET.1, CAMERA_TARGET.2),
        vec3(CAMERA_UP.0, CAMERA_UP.1, CAMERA_UP.2),
        degrees(CAMERA_FOV_DEGREES),
        CAMERA_NEAR,
        CAMERA_FAR,
    );

    // カメラコントローラーの設定（マウスで視点操作可能）
    let mut control = OrbitControl::new(camera.target(), ORBIT_MIN_DISTANCE, ORBIT_MAX_DISTANCE);

    // 立方体の作成
    let mut cube = Gm::new(
        Mesh::new(&context, &CpuMesh::cube()),
        PhysicalMaterial::new_opaque(
            &context,
            &CpuMaterial {
                albedo: CUBE_COLOR,
                ..Default::default()
            },
        ),
    );

    // 光源の設定
    let light = DirectionalLight::new(
        &context,
        DIRECTIONAL_LIGHT_INTENSITY,
        Srgba::WHITE,
        vec3(
            DIRECTIONAL_LIGHT_DIRECTION.0,
            DIRECTIONAL_LIGHT_DIRECTION.1,
            DIRECTIONAL_LIGHT_DIRECTION.2,
        ),
    );
    let ambient = AmbientLight::new(&context, AMBIENT_LIGHT_INTENSITY, Srgba::WHITE);

    // 回転角度（ラジアン）
    let mut angle: f32 = 0.0;

    // メインループ
    window.render_loop(move |mut frame_input| {
        // ビューポートの更新
        camera.set_viewport(frame_input.viewport);

        // マウス操作でカメラを更新
        control.handle_events(&mut camera, &mut frame_input.events);

        // フレームレートに依存しない回転
        // elapsed_time はミリ秒単位なので秒に変換
        #[allow(clippy::cast_possible_truncation)]
        let delta_time = frame_input.elapsed_time as f32 / 1000.0;
        angle += ROTATION_SPEED * delta_time;
        cube.set_transformation(Mat4::from_angle_y(radians(angle)));

        // フレームをレンダリング
        frame_input
            .screen()
            .clear(ClearState::color_and_depth(
                BACKGROUND_COLOR.0,
                BACKGROUND_COLOR.1,
                BACKGROUND_COLOR.2,
                BACKGROUND_COLOR.3,
                1.0,
            ))
            .render(&camera, &cube, &[&light, &ambient]);

        FrameOutput::default()
    });
}
```

実行すると、以下のように青い立方体がY軸を中心に回転するウィンドウが表示されます。ウィンドウを閉じるとプログラムは終了します。

<video autoplay loop muted playsinline width="400">
  <source src="../videos/three-d-video.webm" type="video/webm">
  お使いのブラウザは動画タグをサポートしていません。
</video>

### カメラ操作

`OrbitControl`を有効にした`three-d`のウィンドウでは、マウスを使って直感的にカメラを操作できます。

- **左ドラッグ**: カメラをターゲットの周りに回転させます。
- **右ドラッグ**: カメラを平行移動させます。
- **スクロール**: ターゲットに近づいたり遠ざかったりします（ズーム）。

## まとめ

本節では、数値計算結果を可視化するための手法について紹介しました。

> [!IMPORTANT]
>
> - **可視化ツールは任意に選択可能です**。本書では`plotters`と`three-d`を紹介しますが、Python、`gnuplot`、Excelなど、ご自身が習熟されているツールの使用を推奨します。
> - **CSVファイルへの出力**は、ツール間のデータ連携において利便性が高いため、推奨される手法です。
> - 本書の学習における中核は**数値計算アルゴリズムとそのRustによる実装**であり、可視化はあくまで結果を検証・分析するための一手段です。

次節では、本書全体の構成と学習の進め方について、より詳細に解説します。
