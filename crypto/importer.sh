#!/bin/sh

# This file is part of tgl-library
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# Copyright Ben Wiederhake 2015

set -e

for dst in aes bn err hmac md5 pem rand rsa sha
do
  cpptag=__TGL_CRYPTO_`echo $dst | tr '[a-z]' '[A-Z]'`_H__
  cat raw_header.inc - <<MYEOF > $dst".h"
#ifndef $cpptag
#define $cpptag

/* Declarations go here. */

#endif
MYEOF
  cat raw_header.inc - <<MYEOF > $dst"_openssl.c"
#ifndef TGL_AVOID_OPENSSL

#include "$dst.h"

#include <openssl/$dst.h>

/* FIXME */
#error Not yet implemented: OpenSSL-dependent defines

#endif
MYEOF
  cat raw_header.inc - <<MYEOF > $dst"_altern.c"
#ifdef TGL_AVOID_OPENSSL

#include "$dst.h"

// #include <gcrypt/$dst.h>
// Or similar

/* FIXME */
#error Not yet implemented: OpenSSL-independent defines

#endif
MYEOF
done
