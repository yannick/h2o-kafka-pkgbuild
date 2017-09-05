# Maintainer: Yannick Koechlin <yannick.koechlin@tamedia.ch>

pkgname=h2o-future
pkgver=r4129.7284339f
pkgrel=1
pkgdesc="Optimized HTTP server with support for HTTP/1.x and HTTP/2. git version with extra gems"
arch=('i686' 'x86_64')
depends=('libuv' 'libyaml' 'wslay' 'zlib')
makedepends=('cmake' 'libtool' 'make' 'pkg-config')
url="https://github.com/h2o/h2o"
license=('MIT')
source=("$pkgname"::'git+https://github.com/tamediadigital/h2o.git#branch=distribution'
        h2o.service
	mruby_config.rb
)
sha256sums=('SKIP'
            '8a85462b6798deaaab343b5dae73437e251c5018d70d260a4a4440b9bbb053e6'
	    'SKIP'
)
backup=('etc/h2o.conf')
provides=('h2o' 'libh2o')
conflicts=('libh2o' 'h2o')

pkgver() {
	cd "$srcdir/${pkgname}"
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}


build() {
  cd "$srcdir/$pkgname"
#  cp ../../mruby_config.rb misc/mruby_config.rb
#  git clone https://github.com/mruby/mruby deps/mruby
  git submodule update --init --recursive  
  msg2 'Building...'
  cmake \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR='/usr/lib' \
    -DCMAKE_SKIP_RPATH='TRUE' \
    -DWITH_BUNDLED_SSL=OFF \
    -DOPENSSL_ROOT_DIR=/usr \
    -DWITH_RDKAFKA=on \
    -DEXTRA_LIBS="" \
    -DWITH_MRUBY=on \
.
#    -DCMAKE_BUILD_TYPE=Debug \
#  .
  make
  make libh2o
}

package() {
  cd "$srcdir/$pkgname"

  msg2 'Installing license...'
  install -Dm 644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

  msg2 'Installing documentation...'
  install -Dm 644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"

  msg2 'Installing systemd service...'
  install -Dm 644 "$srcdir/h2o.service" "$pkgdir/usr/lib/systemd/system/h2o.service"

  msg2 'Installing conf file...'
  install -Dm 644 examples/h2o/h2o.conf "$pkgdir/etc/h2o.conf"

  msg2 'Installing...'
  make DESTDIR="$pkgdir" install
}
