# 32-bit requests.so on glibc 2.17 (CentOS 7 based manylinux2014): loads on any Linux with glibc >= 2.17.
FROM quay.io/pypa/manylinux2014_i686

ENV PATH=/opt/python/cp310-cp310/bin:$PATH \
    CONAN_USER_HOME=/conan

RUN yum install -y perl-IPC-Cmd perl-Data-Dumper perl-Time-Piece && yum clean all
RUN pip install --no-cache-dir "conan<2" "cmake<4"
COPY conan-profile /conan/.conan/profiles/default

WORKDIR /src
COPY . .

# conan cache survives rebuilds; the plugin lands in /src/build/lib
RUN --mount=type=cache,target=/conan/.conan/data \
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build -j"$(nproc)"
