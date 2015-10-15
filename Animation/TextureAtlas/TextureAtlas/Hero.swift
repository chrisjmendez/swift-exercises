// ---------------------------------------
// Sprite definitions for 'Hero'
// Generated with TexturePacker 3.9.4
//
// http://www.codeandweb.com/texturepacker
// ---------------------------------------

import SpriteKit


class Hero {

    // sprite names
    let WINGS01 = "Wings01"
    let WINGS02 = "Wings02"
    let WINGS03 = "Wings03"
    let WINGS04 = "Wings04"


    // load texture atlas
    let textureAtlas = SKTextureAtlas(named: "Hero")


    // individual texture objects
    func Wings01() -> SKTexture { return textureAtlas.textureNamed(WINGS01) }
    func Wings02() -> SKTexture { return textureAtlas.textureNamed(WINGS02) }
    func Wings03() -> SKTexture { return textureAtlas.textureNamed(WINGS03) }
    func Wings04() -> SKTexture { return textureAtlas.textureNamed(WINGS04) }


    // texture arrays for animations
    func Wings() -> [SKTexture] {
        return [
            Wings01(),
            Wings02(),
            Wings03(),
            Wings04()
        ]
    }


}
