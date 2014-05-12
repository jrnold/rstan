#!/bin/bash
# depends: git, bcp
RSTAN_INCLUDE=rstan/rstan/inst/include
RSTAN_STANLIB=${RSTAN_INCLUDE}/stanlib
EIGEN_FOR_RSTAN=${RSTAN_STANLIB}/eigen
BOOST_FOR_RSTAN=${RSTAN_STANLIB}/boost
RSTAN_STANSRC=${RSTAN_INCLUDE}/stan

BOOSTPATH=`find ./stan/lib -path '*lib/boost_*' -regex '.*lib\/boost_[^/]*'`
echo "boost path: $BOOSTPATH"
EIGENPATH=`find ./stan/lib -path '*lib/eigen_*' -regex '.*lib\/eigen_[^/]*'`
echo "eigen path: $EIGENPATH"
STANPATH=./stan/src/

# Update git
git submodule init
git submodule update

[ -e $RSTAN_STANLIB ] &&  rm -rf $RSTAN_STANLIB
mkdir -p $RSTAN_STANLIB

## Eigen
mkdir -p $EIGEN_FOR_RSTAN
cp -r ${EIGENPATH}/* $EIGEN_FOR_RSTAN

## Boost
mkdir -p $BOOST_FOR_RSTAN
find ./stan/src/ -name \*\.\[ch]pp -exec bcp --scan --boost=${BOOSTPATH} '{}' ${BOOST_FOR_RSTAN} \; &> bcp.log
find ./rstan/rstan/inst/include -name \*\.\[ch]pp -exec bcp --scan --boost=${BOOSTPATH} '{}' ${BOOST_FOR_RSTAN} \; >> bcp.log  2>&1
					 
## stansrc
[ -e $RSTAN_STANSRC ] &&  rm -rf $RSTAN_STANSRC
mkdir -p $RSTAN_STANSRC
cp -r ${STANPATH}/stan.hpp ${STANPATH}/stan ${STANPATH}/models $RSTAN_STANSRC
