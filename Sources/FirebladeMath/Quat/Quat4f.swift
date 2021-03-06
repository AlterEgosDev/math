//
//  Quat4f.swift
//
//
//  Created by Christian Treffs on 23.07.19.
//

extension Quat4f {
    @inlinable public var normalized: Quat4f {
        normalize(self)
    }

    /// The length of the quaternion `q`.
    @inlinable public var length: Float {
        FirebladeMath.length(self)
    }

    /// Returns the axis about which a quaternion rotates.
    @inlinable public var axis: Vec3f {
        FirebladeMath.axis(self)
    }

    @inlinable public var angle: Float {
        FirebladeMath.angle(self)
    }

    @inlinable public var inverse: Quat4f {
        FirebladeMath.inverse(self)
    }

    @inlinable public var conjugate: Quat4f {
        FirebladeMath.conjugate(self)
    }

    @inlinable public var isNaN: Bool {
        x.isNaN || y.isNaN || z.isNaN || w.isNaN
    }

    public init(angle angleRadians: Float, axis: SIMD3<Float>) {
        self = quaternion(angle: angleRadians, axis: axis)
    }

    public init(rotation matrix: Mat3x3f) {
        self = quaternion(matrix: matrix)
    }

    public init(rotation matrix: Mat4x4f) {
        self = quaternion(matrix: matrix)
    }

    public init(from: SIMD3<Float>, to: SIMD3<Float>) {
        self = quaternion(from: from, to: to)
    }

    public init(yaw: Float, pitch: Float, roll: Float) {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles
        // Abbreviations for the various angular functions
        let cy: Float = cos(roll * 0.5)
        let sy: Float = sin(roll * 0.5)
        let cp: Float = cos(yaw * 0.5)
        let sp: Float = sin(yaw * 0.5)
        let cr: Float = cos(pitch * 0.5)
        let sr: Float = sin(pitch * 0.5)

        let w: Float = cy * cp * cr + sy * sp * sr
        let x: Float = cy * cp * sr - sy * sp * cr
        let y: Float = sy * cp * sr + cy * sp * cr
        let z: Float = sy * cp * cr - cy * sp * sr
        self.init(x, y, z, w)
    }

    /// Calculate the local yaw element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Z of the quaternion onto the ZX plane,
    /// the angle between it and global Z is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Yaw would be left/right rotation around the Y axis (vertical) on the XZ plane.
    /// Yaw is used when driving a car.
    @inlinable public var yaw: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L508
        asin(-2 * (x * z - w * y))
    }

    /// Calculate the local pitch element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local Y of the quaternion onto the YZ plane,
    /// the angle between it and global Y is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Pitch is up/down rotation around the X axis (horizontal, pointing right) on the YZ plane.
    /// Pitch is used when flying a jet down or up, or when driving up hill or down.
    @inlinable public var pitch: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L484
        atan2(2.0 * (y * z + w * x), w * w - x * x - y * y + z * z)
    }

    /// Calculate the local roll element of this quaternion in radians.
    ///
    /// Returns the 'intuitive' result that is, if you projected the local X of the quaternion onto the XY plane,
    /// the angle between it and global X is returned.
    /// The co-domain of the returned value is from -180 to 180 degrees.
    ///
    /// Roll is tilt rotation around the Z axis (pointing towards you) on the XY plane.
    /// Roll is literally what happens to your car when you take a curve too fast!
    @inlinable public var roll: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L459
        atan2(2.0 * (x * y + w * z), w * w + x * x - y * y - z * z)
    }

    /// x: yaw, y: pitch, z: roll
    @inlinable public var eulerAngles: Vec3f {
        /// https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles

        let sinrcosp: Float = +2.0 * (w * x + y * z)
        let cosrcosp: Float = +1.0 - 2.0 * (x * x + y * y)
        let pitch: Float = atan2(sinrcosp, cosrcosp)

        // y-axis rotation
        let sinp: Float = +2.0 * (w * y - z * x)
        let yaw: Float
        if abs(sinp) >= 1 {
            yaw = copysign(.pi / 2.0, sinp) // use 90 degrees if out of range
        } else {
            yaw = asin(sinp)
        }

        // z-axis rotation
        let sinycosp: Float = +2.0 * (w * z + x * y)
        let cosycosp: Float = +1.0 - 2.0 * (y * y + z * z)
        let roll = atan2(sinycosp, cosycosp)

        return Vec3f(yaw, pitch, roll)
    }

    /// Returns the rotation angle of the quaternion in radians.
    ///
    /// NOTE: DO NOT USE simd_angle() or .angle on the quaternion since it will always produce `3.1415927`
    @inlinable public var rotationAngle: Float {
        /// https://github.com/OGRECave/ogre/blob/master/OgreMain/src/OgreQuaternion.cpp#L126

        // The quaternion representing the rotation is
        //   q = cos(A/2)+sin(A/2)*(x*i+y*j+z*k)
        let angle: Float
        let fSqrLength: Float = x * x + y * y + z * z
        if  fSqrLength > 0.0 {
            angle = 2.0 * acos(w)
        } else {
            // angle is 0 (mod 2*pi), so any axis will do
            angle = radians(0.0)
        }

        return angle
    }

    /// The (multiplicative) inverse of the quaternion `q`.
    /*@inlinable public var inverse: Quat4f {
     return simd_inverse(self)
     }*/
}
