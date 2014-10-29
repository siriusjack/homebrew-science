require "formula"

class Kvs < Formula
  homepage "https://code.google.com/p/kvs/"
  url "https://dl.dropboxusercontent.com/u/19518526/kvs/kvs-2.3.2.tar.gz"
  # sha1 "ba1ce51cecdb499a520fe6c4e6f6edf9f45a00d3"

  depends_on "cmake" => :build
  depends_on "freeglut"
  depends_on "glew"
  depends_on "qt" => :optional
  option "with-qt", "enable kvsSupportQT"
  option "with-cuda", "enable kvsSupportCUDA"

  def install
    args = std_cmake_args + %W[
      -DKVS_SUPPORT_GLUT
    ]
    if build.with? "qt" or build.with? "qt5"
      args << '-DKVS_SUPPORT_QT'
    end
    
    mkdir 'install'
    system "cmake", *args
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test kvs`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
