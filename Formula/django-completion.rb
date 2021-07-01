class DjangoCompletion < Formula
  desc "Bash completion for Django"
  homepage "https://www.djangoproject.com/"
  url "https://github.com/django/django/archive/3.2.5.tar.gz"
  sha256 "3c3a3e95ed1e115192b48f39e8cf4ffe5181e5e5051023ae2a7657cff354f8b3"
  license "BSD-3-Clause"
  head "https://github.com/django/django.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, all: "5b8a239c5e46489bff17b32c603b0f5d7fe390ad7c3149434f05045c7fed0f19"
  end

  def install
    bash_completion.install "extras/django_bash_completion" => "django"
  end

  test do
    assert_match "-F _django_completion",
      shell_output("source #{bash_completion}/django && complete -p django-admin.py")
  end
end
