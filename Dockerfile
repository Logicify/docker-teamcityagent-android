FROM logicify/teamcityagent-common

MAINTAINER Alexander Beskrovny <alexander.beskrvny@logicify.com>

USER root

ENV ANDROID_SDK_VERSION=24.3.4

RUN cd /opt && curl -o android-sdk.tgz -L  dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz

RUN cd /opt && tar zxvf android-sdk.tgz && mv android-sdk-linux android-sdk && rm -f android-sdk.tgz \
    && chmod -R +x android-sdk/tools/*

ENV ANDROID_HOME=/opt/android-sdk

ENV PATH="$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools"

RUN echo y | android update sdk --all --filter platform-tools,build-tools-23.0.1,extra-android-support --no-ui --force
RUN echo y | android update sdk --all --filter sysimg-16,android-16 --no-ui --force
RUN echo y | android update sdk --all --filter sysimg-17,android-17 --no-ui --force
RUN echo y | android update sdk --all --filter sysimg-19,android-19 --no-ui --force
RUN echo y | android update sdk --all --filter sysimg-22,android-22 --no-ui --force

RUN cd /opt && chmod -R +x android-sdk/build-tools/*

RUN yum install glibc.i686 zlib.i686 libstdc++.i686 ncurses-libs.i686 libgcc.i686 -y

USER app
