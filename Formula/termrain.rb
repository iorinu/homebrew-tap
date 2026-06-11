class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.3.1"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.1/termrain-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "ed4e0835deb7bc52434bbdc08ee96eff1fb89a204ec19abc02b365d5a32a0936"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.3.1/termrain-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "3317b52c9413da6ae7ea056af3c4785b0a4207174051b3e334b746e94ba76f8c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.3.1/termrain-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9d4c6221b9e42ddba653b2ffa49bc4c1bea656bb2a88ea4df6c22ff0235f7c94"
  end

  def install
    bin.install "termrain"

    # bash / zsh / fish の補完スクリプトを自動生成して所定の場所に置く。
    # `termrain --completion <shell>` が stdout に補完を出すので、
    # Homebrew のヘルパーがそれを拾って install してくれる。
    generate_completions_from_executable(bin/"termrain", "--completion")

    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover = Dir["*"] - doc_files - ["termrain"]
    pkgshare.install(*leftover) unless leftover.empty?
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/termrain --version")
  end
end
