require "formula"

class Kvs < Formula
  homepage "https://code.google.com/p/kvs/"
  url "https://dl.dropboxusercontent.com/u/19518526/kvs/kvs-2.3.0.tar.gz"
  # url "https://dl.dropboxusercontent.com/u/19518526/kvs-2.3.0.tar.gz"
  # sha1 "ba1ce51cecdb499a520fe6c4e6f6edf9f45a00d3"
  
  # dependencies
  depends_on "cmake" => :build
  depends_on "freeglut"
  depends_on "glew"
  depends_on "opencv" => :optional
  depends_on "qt" => :optional

  # options
  option "debug_and_release" "--Default"
  option "debug", "Build with debug options"
  option "release", "Build with release option"

  option "with-opencv", "enable kvsSupoprtOpenCV"
  option "with-qt", "enable kvsSupportQT"
  #option "with-cuda", "enable kvsSupportCUDA"


  def add_optional_args(args)
    # set optional flags
    if true
      args << '-DKVS_SUPPORT_GLUT=ON'
    end
    if build.with? "opencv"
      args << '-DKVS_SUPPORT_OPENCV=ON'
    end
    if build.with? "qt" or build.with? "qt5"
      args << '-DKVS_SUPPORT_QT=ON'
    end
    return  args
  end


  def install
    # build & install
    if build.with? "debug" or "debug_and_release"
      args = std_cmake_args
      args = add_optional_args(args)
      args << '-DDEBUG=ON'
      system "cmake", *args
      system "make", "install"
    end
    if build.with? "release" or "debug_and_release"
      args = std_cmake_args
      args = add_optional_args(args)
      args << '-DRELEASE=ON'
      system "cmake", *args
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
