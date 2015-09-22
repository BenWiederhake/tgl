#!/bin/sh

set -e

for dst in aes bn err hmac md5 pem rand rsa sha
do
  cpptag=__CRYPTO_`echo $dst | tr '[a-z]' '[A-Z]'`_H__
  cat <<MYEOF > $dst.h
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
