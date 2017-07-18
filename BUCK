# Copyright 2017-present, Morphling, Inc.
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

apple_resource(
  name = 'muhanCouponResources',
  files = glob(['*.png']),
  dirs = [],
)

apple_bundle(
  name = 'muhanCoupon',
  binary = ':muhanCouponBinary',
  extension = 'app',
  info_plist = 'Info.plist',
)

apple_binary(
  name = 'muhanCouponBinary',
  deps = [':muhanCouponResources'],
  preprocessor_flags = ['-fobjc-arc', '-Wno-objc-designated-initializers'],
  headers = glob([
    '*.h',
    'muhanCoupon/**/*.h',
  ]),
  srcs = glob([
    '*.m',
    'muhanCoupon/**/*.m',
  ]),
  frameworks = [
    '$SDKROOT/System/Library/Frameworks/UIKit.framework',
    '$SDKROOT/System/Library/Frameworks/Foundation.framework',
    '$SDKROOT/System/Library/Frameworks/CoreGraphics.framework',
    '$SDKROOT/System/Library/Frameworks/AVFoundation.framework',
  ],
)

apple_package(
  name = 'muhanCouponPackage',
  bundle = ':muhanCoupon',
)

