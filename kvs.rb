require "formula"

class Kvs < Formula
  homepage "https://code.google.com/p/kvs/"
  url "https://dl.dropboxusercontent.com/u/19518526/kvs/kvs-2.4.0.tar.gz"
  # sha1 "ba1ce51cecdb499a520fe6c4e6f6edf9f45a00d3"
  
  # dependencies
  depends_on "cmake" => :build
  depends_on "freeglut"
  depends_on "glew"
  depends_on "opencv" => :optional
  depends_on "qt" => :optional
  depends_on "qt5" => :optional

  # options
  option "debug-and-release", "Build both debug and release build (Default)"
  option "debug"
  option "release"
  option "with-opencv", "enable kvsSupoprtOpenCV"
  option "with-qt", "enable kvsSupportQT"
  option "with-qt5", "enable kvsSupportQT"
  option "without-tools", "install kvstools"
  #option "with-cuda", "enable kvsSupportCUDA"

  def add_optional_args(args)
    # set optional flags
    if true
      args << '-DKVS_SUPPORT_GLUT=ON'
    end
    if build.with? "opencv"
      args << '-DKVS_SUPPORT_OPENCV=ON'
    end
    if build.with? "qt"
      args << '-DKVS_SUPPORT_QT=ON'
    end
    if build.with? "qt5"
      args << '-DKVS_SUPPORT_QT=ON'
    end
    if build.with? "without-tools"
      args << '-DKVS_TOOL=OFF'
    end
    return args
  end

  def build_install_debug
    args = std_cmake_args
    # fixed: https://github.com/Homebrew/homebrew/issues/8022
    # args = " -DCMAKE_INSTALL_PREFIX='#{prefix}'"
    args << '-DCMAKE_BUILD_TYPE=debug'
    args << '-DDEBUG=ON'
    args = add_optional_args(args)
    # system "make"
    mkdir "build_debug" do
      system "cmake", "..", *args
      system "make", "install"
    end 
  end

  def build_install_release
    args = std_cmake_args
    # args = "-DCMAKE_INSTALL_PREFIX='#{prefix}'"
    args << '-DCMAKE_BUILD_TYPE=release'
    args << '-DRELEASE=ON'
    args = add_optional_args(args)
    mkdir "build_release" do
      system "cmake", "..", *args
      system "make", "install"
    end 
  end

  def install
    if build.include? "debug"
      build_install_debug()
    elsif build.include? "release"
      build_install_release()
    else # default: 
      build_install_debug()
      build_install_release()
    end
  end

  def caveats
    s = <<-EOS.undent
      Print some important notice to the user when `brew info <formula>` is
      called or when brewing a formula.
      This is optional. You can use all the vars like #{version} here.
    EOS

    if build.with? "qt5" 
      s += <<-EOS.undent

        if you want to use find_papckage(Qt5XXXXX) in your cmake project, 
        you should add -DCMAKE_PREFIX_PATH=/usr/local/opt/qt5 to enable 
        that feature.

      EOS
    end
    #s += "Some issue only on older systems" if MacOS.version < :mountain_lion
    s
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