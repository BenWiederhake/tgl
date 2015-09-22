#!/bin/sh

set -e

for dst in aes bn err hmac md5 pem rand rsa sha
do
  cpptag=__CRYPTO_`echo $dst | tr '[a-z]' '[A-Z]'`_H__
  cat <<MYEOF > $dst.h
/* 
    This file is part of tgl-library

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

    Copyright Vitaly Valtman 2013-2015
*/

#ifndef $cpptag
#define $cpptag

#ifdef TGL_AVOID_OPENSSL
#  warning "Can't avoid OpenSSL for $dst.h yet."
#  include <openssl/$dst.h>
#else
#  include <openssl/$dst.h>
#endif

#endif
MYEOF
done
