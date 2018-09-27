class Iamy < Formula
  desc "AWS IAM import and export tool"
  homepage "https://github.com/99designs/iamy"
  url "https://github.com/99designs/iamy/archive/v2.2.0.tar.gz"
  sha256 "be315753cd94a3652cfc0872f56e993c64ea0811247361742e3eb0be2ffcc64d"
  head "https://github.com/99designs/iamy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ef63fa4468700787b0e655453a503db2b949385c7efdbfe07073d04ae9f671a" => :mojave
    sha256 "65aec3b7fda4554e1ae2d68a1f1828b237767d9d1b03e1a4010147dec671d07f" => :high_sierra
    sha256 "0032e8af26d5f19e127680b3c2a46edf8acfcdcc43705ec28c59c29b5cb7cf8e" => :sierra
    sha256 "e423ebfa60cb94e4af9d2bbe396c10791201f5be000da123981dbbce8bfca5fe" => :el_capitan
    sha256 "7711c9a181026bbb9f662fa04b08da34cff6a3bc7744b5e7546e47bf1615b1b0" => :yosemite
  end

  depends_on "go" => :build
  depends_on "awscli"

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/99designs/iamy"
    dir.install buildpath.children
    cd dir do
      system "go", "build", "-o", bin/"iamy", "-ldflags",
             "-X main.Version=v#{version}"
      prefix.install_metafiles
    end
  end

  test do
    ENV.delete "AWS_ACCESS_KEY"
    ENV.delete "AWS_SECRET_KEY"
    output = shell_output("#{bin}/iamy pull 2>&1", 1)
    assert_match "Can't determine the AWS account", output
  end
end
