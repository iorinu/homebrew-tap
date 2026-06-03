class Pwatch < Formula
  desc "A fast, friendly CLI/TUI tool for viewing port usage and killing processes."
  homepage "https://github.com/iorinu/pwatch"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/iorinu/pwatch/releases/download/v0.1.0/pwatch-aarch64-apple-darwin.tar.xz"
      sha256 "6d00af27bfed347b75da224cb355c79d2de5270b989039ffdf95a51918879d16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/iorinu/pwatch/releases/download/v0.1.0/pwatch-x86_64-apple-darwin.tar.xz"
      sha256 "6f3ff87dd86434472cca2b9dc34fb5ba0034290cf29880336b46f0a19efd728c"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/iorinu/pwatch/releases/download/v0.1.0/pwatch-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "7e5de9576ea949f1b98b56e0e6e3ba87ca20b0f7e0755cdafe29bf41743537fc"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "pwatch" if OS.mac? && Hardware::CPU.arm?
    bin.install "pwatch" if OS.mac? && Hardware::CPU.intel?
    bin.install "pwatch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # シェル補完を生成してインストール（bash / zsh / fish）
    generate_completions_from_executable(bin/"pwatch", "completion")

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
