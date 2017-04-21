Pod::Spec.new do |s|
  s.name     = 'SKAControlSprite'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'SKAControlSprite is a simple SpriteKit implementation of UIControl'
  s.homepage = 'http://spritekitalliance.com/'
  s.social_media_url = 'https://twitter.com/SKADevs'
  s.authors  = {
                 'Norman Croan'  => 'ncroan@gmail.com',
                 'Ben Kane'      => 'ben.kane27@gmail.com',
                 'Max Kargin'    => 'maksym.kargin@gmail.com',
                 'Skyler Lauren' => 'skyler@skymistdevelopment.com',
                 'Marc Vandehey' => 'marc.vandehey@gmail.com'
               }
  s.source   = {
                 :git => 'https://github.com/SpriteKitAlliance/SKAControlSprite.git',
                 :tag => s.version.to_s
               }

  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.source_files = 'Source/*.swift'
  s.frameworks  = 'SpriteKit'
end
