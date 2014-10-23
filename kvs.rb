require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Kvs < Formula
  homepage "https://code.google.com/p/kvs/"
  url "https://dl.dropboxusercontent.com/u/19518526/kvs/kvs-2.3.0.tar.gz"
  sha1 "ba1ce51cecdb499a520fe6c4e6f6edf9f45a00d3"

  depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "freeglut" => :recommended
  depends_on "glew" => :recommended
  depends_on "qt" => :optional

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    # system "./configure", "--disable-debug",
    #                       "--disable-dependency-tracking",
    #                       "--disable-silent-rules",
    #                       "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    # system "make", "install" # if this fails, try separate make/make install steps
    mkdir 'install'
    mkdir 'build' do
      system "cmake", ".."
      system "make"
      system "make", "install"
    end
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
