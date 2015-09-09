FROM logicify/teamcityagent-common

MAINTAINER Alexander Beskrovny <alexander.beskrvny@logicify.com>

USER root

ENV ANDROID_SDK_VERSION=24.3.4

RUN cd /opt && curl -o android-sdk.tgz -L  dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz

RUN cd /opt && tar zxvf android-sdk.tgz && mv android-sdk-linux android-sdk && rm -f android-sdk.tgz \
    && chmod -R +x android-sdk/tools/*


ENV ANDROID_HOME=/opt/android-sdk/android-sdk-linux

ENV PATH="$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools"

RUN echo y | android update sdk --filter platform-tools,build-tools-19.0.3,sysimg-17,android-17,extra-android-support --no-ui --force
RUN echo y | android update sdk --filter sysimg-19,android-19 --no-ui --force
RUN echo y | android update sdk --filter sysimg-22,android-22 --no-ui --force

USER app