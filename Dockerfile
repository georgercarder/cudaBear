# syntax=docker/dockerfile:1

FROM archlinux

# order of these is important 
RUN yes | pacman -Syyuu
RUN yes | pacman -Sy jack2
RUN yes | pacman -Sy freetype2 
RUN yes | pacman -Sy libglvnd
RUN yes | pacman -Sy ffmpeg

RUN yes | pacman -Sy gcc make cmake
RUN yes | pacman -U https://archive.archlinux.org/packages/i/intel-tbb/intel-tbb-2017_20170412-1-x86_64.pkg.tar.xz

RUN yes | pacman -U https://archive.archlinux.org/packages/c/cmake/cmake-3.24.1-1-x86_64.pkg.tar.zst \
https://archive.archlinux.org/packages/g/gcc-fortran/gcc-fortran-12.2.0-1-x86_64.pkg.tar.zst \
https://archive.archlinux.org/packages/g/gcc-libs/gcc-libs-12.2.0-1-x86_64.pkg.tar.zst \
https://archive.archlinux.org/packages/g/gcc/gcc-12.2.0-1-x86_64.pkg.tar.zst 


RUN yes | pacman -U https://archive.archlinux.org/packages/c/cuda/cuda-11.8.0-1-x86_64.pkg.tar.zst

RUN yes | pacman -Sy opencl-nvidia nvidia-utils gtk3 nvidia-settings

WORKDIR /home

RUN yes | pacman -Sy git
RUN git clone https://github.com/opencv/opencv.git

RUN mkdir /home/opencv/build
WORKDIR /home/opencv/build
RUN git checkout 3.4.20

RUN cmake /home/opencv/ \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D WITH_CUDA=ON \
-D CUDA_FAST_MATH=ON \
-D ENABLE_FAST_MATH=ON \ 
-D WITH_CUBLAS=ON \
-D WITH_CUFFT=ON \
-D WITH_NVCUVID=ON \
-D WITH_OPENMP=ON \
-D WITH_IPP=ON \
-D WITH_CSTRIPES=ON \
-D WITH_OPENCL=ON \
-D WITH_FFMPEG=ON \
-D WITH_CUDNN=ON \
-D OPENCV_DNN_CUDA=ON


RUN make

RUN make install
