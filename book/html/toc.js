// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="index.html">はじめに</a></li><li class="chapter-item expanded affix "><li class="part-title">第1部: 基礎編</li><li class="chapter-item expanded "><a href="ch01-introduction/index.html"><strong aria-hidden="true">1.</strong> Rustと計算物理学</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch01-introduction/why-rust.html"><strong aria-hidden="true">1.1.</strong> なぜRustなのか</a></li><li class="chapter-item expanded "><a href="ch01-introduction/setup.html"><strong aria-hidden="true">1.2.</strong> 開発環境のセットアップ</a></li><li class="chapter-item expanded "><a href="ch01-introduction/how-to-use.html"><strong aria-hidden="true">1.3.</strong> 本書の使い方</a></li></ol></li><li class="chapter-item expanded "><a href="ch02-basics/index.html"><strong aria-hidden="true">2.</strong> 数値計算の基礎</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch02-basics/floating-point.html"><strong aria-hidden="true">2.1.</strong> 浮動小数点演算と誤差</a></li><li class="chapter-item expanded "><a href="ch02-basics/arrays-vectors.html"><strong aria-hidden="true">2.2.</strong> 配列とベクトル演算</a></li><li class="chapter-item expanded "><a href="ch02-basics/ndarray.html"><strong aria-hidden="true">2.3.</strong> 外部クレートの活用（ndarray入門）</a></li><li class="chapter-item expanded "><a href="ch02-basics/xprec.html"><strong aria-hidden="true">2.4.</strong> 高精度演算（xprec-rs）</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">第2部: 数値計算手法</li><li class="chapter-item expanded "><a href="ch03-calculus/index.html"><strong aria-hidden="true">3.</strong> 数値微分と数値積分</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch03-calculus/differentiation.html"><strong aria-hidden="true">3.1.</strong> 数値微分</a></li><li class="chapter-item expanded "><a href="ch03-calculus/integration.html"><strong aria-hidden="true">3.2.</strong> 数値積分（台形則・シンプソン則）</a></li><li class="chapter-item expanded "><a href="ch03-calculus/monte-carlo.html"><strong aria-hidden="true">3.3.</strong> モンテカルロ積分</a></li></ol></li><li class="chapter-item expanded "><a href="ch04-linear-algebra/index.html"><strong aria-hidden="true">4.</strong> 線形代数</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch04-linear-algebra/matrix-ops.html"><strong aria-hidden="true">4.1.</strong> 行列演算の基礎</a></li><li class="chapter-item expanded "><a href="ch04-linear-algebra/linear-systems.html"><strong aria-hidden="true">4.2.</strong> 連立一次方程式（ガウスの消去法）</a></li><li class="chapter-item expanded "><a href="ch04-linear-algebra/eigenvalue.html"><strong aria-hidden="true">4.3.</strong> 固有値問題</a></li></ol></li><li class="chapter-item expanded "><a href="ch05-ode/index.html"><strong aria-hidden="true">5.</strong> 常微分方程式</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch05-ode/euler.html"><strong aria-hidden="true">5.1.</strong> オイラー法</a></li><li class="chapter-item expanded "><a href="ch05-ode/runge-kutta.html"><strong aria-hidden="true">5.2.</strong> ルンゲ=クッタ法</a></li><li class="chapter-item expanded "><a href="ch05-ode/oscillation.html"><strong aria-hidden="true">5.3.</strong> 応用例：単振動と減衰振動</a></li></ol></li><li class="chapter-item expanded "><a href="ch06-pde/index.html"><strong aria-hidden="true">6.</strong> 偏微分方程式</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch06-pde/finite-difference.html"><strong aria-hidden="true">6.1.</strong> 差分法の基礎</a></li><li class="chapter-item expanded "><a href="ch06-pde/diffusion.html"><strong aria-hidden="true">6.2.</strong> 拡散方程式</a></li><li class="chapter-item expanded "><a href="ch06-pde/wave.html"><strong aria-hidden="true">6.3.</strong> 波動方程式</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">第3部: 物理シミュレーション</li><li class="chapter-item expanded "><a href="ch07-classical-mechanics/index.html"><strong aria-hidden="true">7.</strong> 古典力学シミュレーション</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch07-classical-mechanics/particle-motion.html"><strong aria-hidden="true">7.1.</strong> 質点系の運動</a></li><li class="chapter-item expanded "><a href="ch07-classical-mechanics/kepler.html"><strong aria-hidden="true">7.2.</strong> 惑星運動（ケプラー問題）</a></li><li class="chapter-item expanded "><a href="ch07-classical-mechanics/rigid-body.html"><strong aria-hidden="true">7.3.</strong> 剛体の運動</a></li></ol></li><li class="chapter-item expanded "><a href="ch08-monte-carlo/index.html"><strong aria-hidden="true">8.</strong> モンテカルロ法</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch08-monte-carlo/random-walk.html"><strong aria-hidden="true">8.1.</strong> 乱数生成とランダムウォーク</a></li><li class="chapter-item expanded "><a href="ch08-monte-carlo/integration.html"><strong aria-hidden="true">8.2.</strong> モンテカルロ積分の詳細</a></li><li class="chapter-item expanded "><a href="ch08-monte-carlo/importance-sampling.html"><strong aria-hidden="true">8.3.</strong> 重点サンプリング</a></li><li class="chapter-item expanded "><a href="ch08-monte-carlo/mcmc.html"><strong aria-hidden="true">8.4.</strong> マルコフ連鎖モンテカルロ法</a></li></ol></li><li class="chapter-item expanded "><a href="ch09-statistical-mechanics/index.html"><strong aria-hidden="true">9.</strong> 統計力学シミュレーション</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch09-statistical-mechanics/ising-basics.html"><strong aria-hidden="true">9.1.</strong> イジング模型の基礎</a></li><li class="chapter-item expanded "><a href="ch09-statistical-mechanics/metropolis.html"><strong aria-hidden="true">9.2.</strong> メトロポリス法</a></li><li class="chapter-item expanded "><a href="ch09-statistical-mechanics/phase-transition.html"><strong aria-hidden="true">9.3.</strong> 相転移とクリティカル現象</a></li><li class="chapter-item expanded "><a href="ch09-statistical-mechanics/other-models.html"><strong aria-hidden="true">9.4.</strong> その他の格子模型</a></li></ol></li><li class="chapter-item expanded "><a href="ch10-quantum-mechanics/index.html"><strong aria-hidden="true">10.</strong> 量子力学</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch10-quantum-mechanics/schrodinger.html"><strong aria-hidden="true">10.1.</strong> シュレーディンガー方程式の数値解法</a></li><li class="chapter-item expanded "><a href="ch10-quantum-mechanics/harmonic-oscillator.html"><strong aria-hidden="true">10.2.</strong> 調和振動子</a></li><li class="chapter-item expanded "><a href="ch10-quantum-mechanics/potential-well.html"><strong aria-hidden="true">10.3.</strong> ポテンシャル井戸問題</a></li></ol></li><li class="chapter-item expanded "><a href="ch11-fluid-dynamics/index.html"><strong aria-hidden="true">11.</strong> 流体力学</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch11-fluid-dynamics/lattice-boltzmann.html"><strong aria-hidden="true">11.1.</strong> 格子ボルツマン法入門</a></li><li class="chapter-item expanded "><a href="ch11-fluid-dynamics/navier-stokes.html"><strong aria-hidden="true">11.2.</strong> ナビエ-ストークス方程式</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">第4部: 高度なトピック</li><li class="chapter-item expanded "><a href="ch12-parallel/index.html"><strong aria-hidden="true">12.</strong> 並列計算</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch12-parallel/rayon.html"><strong aria-hidden="true">12.1.</strong> RayonによるCPU並列化</a></li><li class="chapter-item expanded "><a href="ch12-parallel/simd.html"><strong aria-hidden="true">12.2.</strong> SIMD最適化</a></li><li class="chapter-item expanded "><a href="ch12-parallel/profiling.html"><strong aria-hidden="true">12.3.</strong> パフォーマンス測定とプロファイリング</a></li></ol></li><li class="chapter-item expanded "><a href="ch13-visualization/index.html"><strong aria-hidden="true">13.</strong> 可視化</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch13-visualization/plotters.html"><strong aria-hidden="true">13.1.</strong> plottersによる2Dプロット</a></li><li class="chapter-item expanded "><a href="ch13-visualization/data-io.html"><strong aria-hidden="true">13.2.</strong> データの保存と読み込み</a></li><li class="chapter-item expanded "><a href="ch13-visualization/animation.html"><strong aria-hidden="true">13.3.</strong> アニメーション作成</a></li></ol></li><li class="chapter-item expanded "><a href="ch14-fft/index.html"><strong aria-hidden="true">14.</strong> FFT（高速フーリエ変換）</a></li><li><ol class="section"><li class="chapter-item expanded "><a href="ch14-fft/dft-basics.html"><strong aria-hidden="true">14.1.</strong> 離散フーリエ変換の基礎</a></li><li class="chapter-item expanded "><a href="ch14-fft/fft-application.html"><strong aria-hidden="true">14.2.</strong> FFTの実装と応用</a></li><li class="chapter-item expanded "><a href="ch14-fft/spectral-analysis.html"><strong aria-hidden="true">14.3.</strong> スペクトル解析</a></li></ol></li><li class="chapter-item expanded "><li class="part-title">付録</li><li class="chapter-item expanded "><a href="appendix/a-references.html"><strong aria-hidden="true">15.</strong> 付録A: 参考資料</a></li><li class="chapter-item expanded "><a href="appendix/b-crates.html"><strong aria-hidden="true">16.</strong> 付録B: 有用なクレート集</a></li><li class="chapter-item expanded "><a href="appendix/c-debugging.html"><strong aria-hidden="true">17.</strong> 付録C: デバッグとトラブルシューティング</a></li><li class="chapter-item expanded "><a href="appendix/d-math-background.html"><strong aria-hidden="true">18.</strong> 付録D: 数学的背景</a></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString().split("#")[0].split("?")[0];
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
