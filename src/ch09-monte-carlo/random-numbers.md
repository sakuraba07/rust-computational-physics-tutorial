# 乱数生成

モンテカルロ法の心臓部は、高品質な**疑似乱数 (Pseudo-random numbers)** です。物理シミュレーションでは、単なる一様乱数だけでなく、特定の確率分布（正規分布や指数分布など）に従う乱数が必要になります。

## Rustにおける乱数: `rand` クレート

Rustの標準ライブラリには乱数生成器が含まれていないため、デファクトスタンダードである [`rand`](https://crates.io/crates/rand) クレートを使用します。

### 依存関係

`Cargo.toml` に以下を追加します。

```toml
[dependencies]
rand = "0.9"
rand_distr = "0.5" # 特定の分布を使用する場合
```

## 基本的な使い方

### 一様乱数の生成

$[0, 1)$ の範囲の実数乱数を生成する例です。

```rust
use rand::prelude::*;

fn main() {
    let mut rng = thread_rng(); // 乱数生成器の初期化

    // 0.0 から 1.0 の間の一様乱数
    let x: f64 = rng.gen();
    println!("Random f64: {}", x);

    // 特定の範囲 [1, 100] の整数
    let n: i32 = rng.gen_range(1..=100);
    println!("Random integer: {}", n);
}
```

## 特定の分布に従う乱数

物理現象をシミュレートする際、正規分布（ガウス分布）に従う乱数がしばしば必要になります。これには `rand_distr` を使用します。

```rust
use rand::prelude::*;
use rand_distr::{Distribution, Normal, Exp};

fn main() {
    let mut rng = thread_rng();

    // 平均 0.0, 標準偏差 1.0 の正規分布
    let normal = Normal::new(0.0, 1.0).unwrap();
    let x = normal.sample(&mut rng);
    println!("Normal: {}", x);

    // 指数分布 (lambda = 1.0)
    let exp = Exp::new(1.0).unwrap();
    let y = exp.sample(&mut rng);
    println!("Exponential: {}", y);
}
```

## 再現性とシード値

物理学の実験と同様に、数値シミュレーションでも結果の**再現性**が重要です。`thread_rng()` は毎回異なるシード値を使いますが、デバッグや論文の結果を固定したい場合は、明示的にシード値を指定できる生成器を使用します。

```rust
use rand::SeedableRng;
use rand_chacha::ChaCha8Rng; // 高品質な生成器

fn main() {
    let seed = [0u8; 32]; // 固定のシード
    let mut rng = ChaCha8Rng::from_seed(seed);

    let x: f64 = rng.gen();
    println!("Always same value: {}", x);
}
```

---

[次節](./integration.md)では、これらの乱数を使って積分を計算する方法を学びます。
