import UIKit
import Hex
import Presentation

class ViewController: PresentationController {

  struct BackgroundImage {
    let name: String
    let left: CGFloat
    let top: CGFloat
    let speed: CGFloat

    init(name: String, left: CGFloat, top: CGFloat, speed: CGFloat) {
      self.name = name
      self.left = left
      self.top = top
      self.speed = speed
    }

    func positionAt(index: Int) -> Position? {
      var position: Position?

      if index == 0 || speed != 0.0 {
        let currentLeft = left + CGFloat(index) * speed
        position = Position(left: currentLeft, top: top)
      }

      return position
    }
  }

  lazy var leftButton: UIBarButtonItem = { [unowned self] in
    let leftButton = UIBarButtonItem(
      title: "Previous",
      style: .Plain,
      target: self,
      action: "previous")

    leftButton.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.blackColor()],
      forState: .Normal)

    return leftButton
    }()

  lazy var rightButton: UIBarButtonItem = { [unowned self] in
    let rightButton = UIBarButtonItem(
      title: "Next",
      style: .Plain,
      target: self,
      action: "next")

    rightButton.setTitleTextAttributes(
      [NSForegroundColorAttributeName : UIColor.blackColor()],
      forState: .Normal)

    return rightButton
    }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setNavigationTitle = false
    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = rightButton

    view.backgroundColor = UIColor(hex: "FFBC00")

    configureSlides()
    configureBackground()
  }

  // MARK: - Configuration

  func configureSlides() {
    let font = UIFont(name: "HelveticaNeue", size: 34.0)!
    let color = UIColor(hex: "FFE8A9")
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.Center

    let attributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: color,
      NSParagraphStyleAttributeName: paragraphStyle]

    let titles = [
      "Parallax is a displacement or difference in the apparent position of an object viewed along two different lines of sight.",
      "It's measured by the angle or semi-angle of inclination between those two lines.",
      "The term is derived from the Greek word παράλλαξις (parallaxis), meaning 'alteration'.",
      "Nearby objects have a larger parallax than more distant objects when observed from different positions.",
      "http://en.wikipedia.org/wiki/Parallax"].map { title -> Content in
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 550, height: 200))
        label.numberOfLines = 5
        label.attributedText = NSAttributedString(string: title, attributes: attributes)
        let position = Position(left: 0.7, top: 0.35)

        return Content(view: label, position: position)
    }

    var slides = [SlideController]()

    for index in 0...4 {
      let controller = SlideController(contents: [titles[index]])
      controller.addAnimations([Content.centerTransitionForSlideContent(titles[index])])

      slides.append(controller)
    }

    add(slides)
  }

  func configureBackground() {
    let backgroundImages = [
      BackgroundImage(name: "Trees", left: 0.0, top: 0.743, speed: -0.3),
      BackgroundImage(name: "Bus", left: 0.02, top: 0.77, speed: 0.25),
      BackgroundImage(name: "Truck", left: 1.3, top: 0.73, speed: -1.5),
      BackgroundImage(name: "Roadlines", left: 0.0, top: 0.79, speed: -0.24),
      BackgroundImage(name: "Houses", left: 0.0, top: 0.627, speed: -0.16),
      BackgroundImage(name: "Hills", left: 0.0, top: 0.51, speed: -0.08),
      BackgroundImage(name: "Mountains", left: 0.0, top: 0.29, speed: 0.0),
      BackgroundImage(name: "Clouds", left: -0.415, top: 0.14, speed: 0.18),
      BackgroundImage(name: "Sun", left: 0.8, top: 0.07, speed: 0.0)
    ]

    var contents = [Content]()

    for backgroundImage in backgroundImages {
      let imageView = UIImageView(image: UIImage(named: backgroundImage.name))
      if let position = backgroundImage.positionAt(0) {
        contents.append(Content(view: imageView, position: position, centered: false))
      }
    }

    addToBackground(contents)

    for row in 1...4 {
      for (column, backgroundImage) in backgroundImages.enumerate() {
        if let position = backgroundImage.positionAt(row), content = contents.at(column) {
          addAnimation(TransitionAnimation(content: content, destination: position,
            duration: 2.0, dumping: 1.0), forPage: row)
        }
      }
    }

    let groundView = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 60))
    groundView.backgroundColor = UIColor(hex: "FFCD41")
    let groundContent = Content(view: groundView,
      position: Position(left: 0.0, bottom: 0.063), centered: false)
    contents.append(groundContent)

    addToBackground([groundContent])
  }
}

extension Array {

  func at(index: Int?) -> Element? {
    var object: Element?
    if let index = index where index >= 0 && index < endIndex {
      object = self[index]
    }

    return object
  }
}
