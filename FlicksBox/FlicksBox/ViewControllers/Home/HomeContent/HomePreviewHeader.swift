//
//  HomePreviewHeader.swift
//  FlicksBox
//
//  Created by Mac-HOME on 02.05.2021.
//

import UIKit
import Botticelli

class HomePreviewHeader: SBView {
    private let titleViewHeight: CGFloat = 50
    
    private lazy var titleView: HomeTableViewHeader = {
        let titleFrame = CGRect(x: 0, y: bounds.maxY - titleViewHeight, width: bounds.width, height: titleViewHeight)
        return HomeTableViewHeader(frame: titleFrame)
    }()
    
    lazy var previewSliderView: PreviewSliderView = {
        let height = bounds.height - titleViewHeight
        let sliderFrame = CGRect(x: 0, y: 0, width: bounds.width, height: height)
        return PreviewSliderView(frame: sliderFrame)
    }()
    
    init(frame: CGRect, content: [ContentInfo]) {
        super.init(frame: frame)
        previewSliderView.updateContent(content)
        addSubview(previewSliderView)
        addSubview(titleView)
    }
    
    func setTitle(title: String) {
        titleView.title = title
    }
    
    func setPreviewContent(content: [ContentInfo]) {
        previewSliderView.updateContent(content)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
