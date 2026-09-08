class Termrain < Formula
  desc "Terminal weather forecast and rain radar TUI (JMA + Open-Meteo, Kitty graphics)"
  homepage "https://github.com/iorinu/termrain"
  version "0.4.0"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/termrain/releases/download/v0.4.0/termrain-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "0f2bb7856f50f8aed660954085f2cdeaa495b83becd1600a3fdb6af60c592ca1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/termrain/releases/download/v0.4.0/termrain-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "7cbdd6b59216aa794e3c010881fd219d51fe20956daecaa4a34756ca5f2c7e29"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/termrain/releases/download/v0.4.0/termrain-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "26f2d4c67c55c724a28de5a8c9cfa1f7e436afe4b00dff1fd5f79508b257491e"
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
