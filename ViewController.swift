//
//  ViewController.swift
//  Plot
//
//  Created by Константин Ким on 10/03/2019.
//  Copyright © 2019 Константин Ким. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var containerView: UIScrollView!
    var titleView: TitleView!
    var titleLowerView: TitleLowerView!
    var chartView: ChartView!
    var slideView: SlideView!
    var legendView: LegendView!
    var switchModeView: SwitchModeView!
    var selectChartView: SelectChartView!

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        Util.load()
//        // Do any additional setup after loading the view, typically from a nib.
//        Dispatcher.putController(viewController: self)
//        self.drawAll(chart: Util.getCurrentChart())
//        self.draw()
    }

    func draw() {
        var containerView = UIScrollView()
        containerView.frame = Util.getContainerViewFrame()
        containerView.contentSize = CGSize(width: Util.getContainerViewFrame().size.width, height: Util.getContainerViewFrame().size.height)
        containerView.showsHorizontalScrollIndicator = false
        containerView.showsVerticalScrollIndicator = false
        containerView.delaysContentTouches = false
        self.view.addSubview(containerView)
        self.view.backgroundColor = Util.getContainerViewBackground()

        var upperView = UIView()
        upperView.frame = CGRect(x: 0.0, y: 0.0, width: containerView.frame.width, height: containerView.frame.height / 2)
        upperView.backgroundColor = Util.getTitleTopViewBackgroundColor()
        containerView.addSubview(upperView)

        
    }



    // ===============================

    func clearAll() {
        for v in self.view.subviews{
            v.removeFromSuperview()
        }
    }

    func drawAll(chart: Chart) {
        self.drawContainerView(chart: chart)
        self.drawTitleView(chart: chart)
        self.drawSlideView(chart: chart)
        self.drawChartView(chart: chart)
        self.drawLegendView(chart: chart)
        self.drawSwitchModeView(chart: chart)
        self.drawSelectChatView(charts: Util.getAllCharts())
    }

    func drawContainerView(chart: Chart) {
        self.containerView = UIScrollView()
        self.containerView.frame = Util.getContainerViewFrame()
        self.containerView.contentSize = CGSize(width: Util.getContainerViewFrame().size.width, height: Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).maxY + Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).size.height)
        self.containerView.showsHorizontalScrollIndicator = false
        self.containerView.showsVerticalScrollIndicator = false
        self.containerView.delaysContentTouches = false
        self.view.addSubview(self.containerView)
        self.view.backgroundColor = Util.getContainerViewBackground()
        Dispatcher.put(id: Dispatcher.CONTAINER_VIEW, uiView: self.view)
    }

    func drawTitleView(chart: Chart) {
        self.titleView = TitleView(x: Util.getTitleViewFrame().origin.x, y: Util.getTitleViewFrame().origin.y, width: Util.getTitleViewFrame().width, height: Util.getTitleViewFrame().height)
        self.titleView.drawTitleView(chart: chart)
        self.titleView.renderTitleView(chart: chart)
        Dispatcher.put(id: Dispatcher.TITLE_VIEW, uiView: self.titleView)
        self.view.addSubview(self.titleView)

        self.titleLowerView = TitleLowerView()
        self.titleLowerView.frame = Util.getTitleLowerViewFrame()
        self.titleLowerView.drawTitleView(chart: chart)
        self.titleLowerView.renderTitleView(chart: chart)
        Dispatcher.put(id: Dispatcher.TITLE_LOWER_VIEW, uiView: self.titleLowerView)
        self.containerView.addSubview(self.titleLowerView)
    }

    func drawChartView(chart: Chart) {
        self.chartView = ChartView(x: Util.getChartViewFrame().origin.x, y: Util.getChartViewFrame().origin.y, width: Util.getChartViewFrame().size.width, height: Util.getChartViewFrame().size.height)
        Dispatcher.put(id: Dispatcher.CHART_VIEW, uiView: self.chartView)
        self.chartView.drawChartView(chart: chart)
        self.chartView.renderChartView(chart: chart)

        self.containerView.addSubview(self.chartView)

    }

    func drawSlideView(chart: Chart) {
        self.slideView = SlideView(x: Util.getSlideViewFrame().origin.x, y: Util.getSlideViewFrame().origin.y, width: Util.getSlideViewFrame().size.width, height: Util.getSlideViewFrame().size.height)
        self.slideView.drawSlideView(chart: chart)
        self.slideView.renderSlideView(chart: chart)
        Dispatcher.put(id: Dispatcher.SLIDE_VIEW, uiView: self.slideView)
        self.containerView.addSubview(self.slideView)
    }

    func drawLegendView(chart: Chart) {
        self.legendView = LegendView(x: Util.getLegendViewFrame(count: chart.timeSeriesList.count).origin.x, y: Util.getLegendViewFrame(count: chart.timeSeriesList.count).origin.y, width: Util.getLegendViewFrame(count: chart.timeSeriesList.count).size.width, height: Util.getLegendViewFrame(count: chart.timeSeriesList.count).size.height)
        self.legendView.drawLegendView(chart: chart)
        self.legendView.renderLegendView(chart: chart)
        Dispatcher.put(id: Dispatcher.LEGEND_VIEW, uiView: self.legendView)
        self.containerView.addSubview(self.legendView)
    }

    func drawSwitchModeView(chart: Chart) {
        self.switchModeView = SwitchModeView(x: Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).origin.x, y: Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).origin.y, width: Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).size.width, height: Util.getSwitchModeViewFrame(count: chart.timeSeriesList.count).size.height)
        self.switchModeView.drawSwitchModeView(chart: chart)
        self.switchModeView.renderSwitchModeView(chart: chart)
        Dispatcher.put(id: Dispatcher.SWITCH_MODE_VIEW, uiView: self.switchModeView)
        self.containerView.addSubview(self.switchModeView)
    }

    func drawSelectChatView(charts: [Chart]) {
        self.selectChartView = SelectChartView()
        self.selectChartView.frame = Util.getSelectChartViewFrame()
        self.selectChartView.drawSelectChartView(charts: charts)
        self.selectChartView.renderSelectChartView()
        Dispatcher.put(id: Dispatcher.SELECT_CHART_VIEW, uiView: self.selectChartView)
        self.view.addSubview(self.selectChartView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        Util.SIZE = size
        self.clearAll()
        self.drawAll(chart: Util.getCurrentChart())
        self.view.setNeedsDisplay()
    }

    class SelectChartView : UIScrollView {

        var containerView: UIView!
        var chartPreviewList: [UIView]!


        func drawSelectChartView(charts: [Chart]) {
            self.containerView = UIView()
            self.containerView.frame = self.bounds
            self.addSubview(self.containerView)

            self.chartPreviewList = [UIView]()
            for (i, e) in charts.enumerated() {
                let size = (self.containerView.frame.size.width - Util.PADDING * 6) / CGFloat(2.0)
                let chartPreviewView = ChartPreviewView()
                chartPreviewView.chart = e
                self.containerView.addSubview(chartPreviewView)
                if i == 0 {
                    chartPreviewView.frame = CGRect(x: Util.PADDING * 2.5, y: self.containerView.frame.size.height / CGFloat(5.0), width: size, height: size)
                } else if i == 1 {
                    chartPreviewView.frame = CGRect(x: size + Util.PADDING + Util.PADDING * 2.5, y: self.containerView.frame.size.height / CGFloat(5.0), width: size, height: size)
                } else if i == 2 {
                    chartPreviewView.frame = CGRect(x: Util.PADDING * 2.5, y: self.containerView.frame.size.height / CGFloat(5.0) + Util.PADDING + size, width: size, height: size)
                } else if i <= 3 {
                    chartPreviewView.frame = CGRect(x: size + Util.PADDING + Util.PADDING * 2.5, y: self.containerView.frame.size.height / CGFloat(5.0) + Util.PADDING + size, width: size, height: size)
                } else {
                    chartPreviewView.frame = CGRect(x: Util.PADDING * 2.5, y: self.containerView.frame.size.height / CGFloat(5.0) + Util.PADDING + size + Util.PADDING + size, width: size, height: size)
                }
                self.contentSize = CGSize(width: self.contentSize.width, height: chartPreviewView.frame.maxY)
                chartPreviewView.layer.cornerRadius = 6.0
                chartPreviewView.layer.borderWidth = 1.0
                for j in e.timeSeriesList {
                    let timeSeriesPreviewLayer = TimeSeriesLayer()
                    timeSeriesPreviewLayer.cornerRadius = 6.0
                    chartPreviewView.layer.addSublayer(timeSeriesPreviewLayer)
                    timeSeriesPreviewLayer.renderTimeSeries(chart: e, timeSeries: j)
                }
                self.chartPreviewList.append(chartPreviewView)

            }
        }

        func renderSelectChartView() {
            self.containerView.backgroundColor = Util.getContainerViewBackground().withAlphaComponent(0.9)
            for i in self.chartPreviewList {
                i.layer.borderColor = Util.getShadowViewBackground().cgColor
                i.backgroundColor = Util.getViewBackground()
            }
            self.transform = self.transform.scaledBy(x: 0.000001, y: 0.000001)
            self.alpha = 0.0

        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: ({
                    Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).transform = Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).transform.scaledBy(x: 0.000001, y: 0.000001)
                    Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).alpha = 0.0
                }), completion: nil)
            }
        }

        class ChartPreviewView : UIView {

            var chart: Chart!

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    Util.CURRENT_CHART = self.chart
                    for i in chart.timeSeriesList {
                        i.hidden = false
                    }
                    Dispatcher.getController().clearAll()
                    Dispatcher.getController().drawAll(chart: self.chart)
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: ({
                        Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).transform = Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).transform.scaledBy(x: 0.000001, y: 0.000001)
                        Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).alpha = 0.0
                    }), completion: nil)
                }
            }
        }

        class TimeSeriesLayer : CAShapeLayer {

            var id: String!
            var chart: Chart!
            var timeSeries: TimeSeries!
            var curvePath: UIBezierPath!
            var curveOpacity: Float!

            func renderTimeSeries(chart: Chart, timeSeries: TimeSeries) {
                self.chart = chart
                self.timeSeries = timeSeries
                var previousCurvePath = self.curvePath
                self.curvePath = UIBezierPath()

                self.lineWidth = 1.0
                self.strokeColor = self.timeSeries.color.cgColor

                var minValue = Float(0.0)
                var maxValue = Float(0.0)
                for i in chart.timeSeriesList {
                    minValue = min(minValue, i.y.min()!)
                    maxValue = max(maxValue, i.y.max()!)
                }
                let difference = CGFloat(maxValue - minValue);

                let height = (self.superlayer!.delegate as! UIView).frame.size.height
                let width = (self.superlayer!.delegate as! UIView).frame.size.width
                let adjustment = 2 + Util.SLIDE_VIEW_PADDING
                var y = [CGFloat]()
                for i in timeSeries.y {
                    y.append(CGFloat(i) / (difference / (height - 2 * adjustment)))
                }
                let interval = (width - Util.SLIDE_VIEW_PADDING * 2) / CGFloat(y.count - 1)
                self.curvePath.move(to: CGPoint(x: Util.SLIDE_VIEW_PADDING, y: height - adjustment - y.first!))
                for (i, e) in y.dropFirst().enumerated() {
                    self.curvePath.addLine(to: CGPoint(x: Util.SLIDE_VIEW_PADDING + CGFloat(i + 1) * interval, y: height - adjustment - e))
                    self.curvePath.move(to: CGPoint(x: Util.SLIDE_VIEW_PADDING + CGFloat(i + 1) * interval, y: height - adjustment - e))
                }



                self.path = self.curvePath.cgPath
            }
        }
    }

    class TitleView : UIView {

        var chart: Chart!
        var topView: UIView!
        var statisticsLabel: UILabel!

        var bottomShadowView: UIView!

        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        }

        func drawTitleView(chart: Chart) {

            // Top View
            self.topView = UIView()
            self.topView.frame = Util.getTitleTopViewFrame()
            self.addSubview(self.topView)

            self.bottomShadowView = UIView()
            self.topView.addSubview(self.bottomShadowView)
            self.bottomShadowView.translatesAutoresizingMaskIntoConstraints = false
            self.bottomShadowView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor).isActive = true
            self.bottomShadowView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor).isActive = true
            self.bottomShadowView.bottomAnchor.constraint(equalTo: self.topView.bottomAnchor).isActive = true
            self.bottomShadowView.heightAnchor.constraint(equalToConstant: Util.SHADOW_HEIGHT).isActive = true

            // Label
            self.statisticsLabel = UILabel()
            self.statisticsLabel.text = "Statistics"
            self.statisticsLabel.frame = Util.getTitleStatisticsLabelFrame()
            self.statisticsLabel.textAlignment = .center
            self.addSubview(self.statisticsLabel)
            // Chart name
//            self.chartNameLabel = UILabel()
//            self.chartNameLabel.text = "FOLLOWERS"
//            self.chartNameLabel.frame = Util.getTitleChartNameLabelFrame()
//            self.chartNameLabel.textAlignment = .left
//            self.addSubview(self.chartNameLabel)


        }



        func renderTitleView(chart: Chart) {
            self.topView.backgroundColor = Util.getTitleTopViewBackgroundColor()
            self.statisticsLabel.textColor = Util.getTitleStatisticsLabelColor()
            self.bottomShadowView.backgroundColor = Util.getShadowViewBackground()

        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    class TitleLowerView : UIView {
        var chartNameLabel: UILabel!
        var changeChartView: ChangeChartView!

        func drawTitleView(chart: Chart) {

            // Chart name
            self.chartNameLabel = UILabel()
            self.chartNameLabel.text = "FOLLOWERS"
            self.chartNameLabel.frame = Util.getTitleChartNameLabelFrame()
            self.chartNameLabel.textAlignment = .left
            self.addSubview(self.chartNameLabel)

            self.changeChartView = ChangeChartView()
            self.changeChartView.frame = Util.getTitleChangeChartFrame()
            self.changeChartView.drawChangeChartView(chart: chart)
            self.addSubview(self.changeChartView)
        }

        func renderTitleView(chart: Chart) {
            self.chartNameLabel.textColor = Util.getTitleChartNameLabelColor()
            self.changeChartView.renderChangeChartView(chart: chart)
        }

        class ChangeChartView : UIView {

            var circleLayer: CAShapeLayer!
            var circlePath: UIBezierPath!

            func drawChangeChartView(chart: Chart) {
                self.circleLayer = CAShapeLayer()
                self.circleLayer.lineWidth = 3.0
                self.layer.addSublayer(self.circleLayer)
            }

            func renderChangeChartView(chart: Chart) {

                self.circleLayer.fillColor = Util.getTitleChartNameLabelColor().cgColor
                self.circleLayer.strokeColor = Util.getTitleChartNameLabelColor().cgColor

                if(self.circlePath == nil) {
                    self.circlePath = UIBezierPath()
                }

                self.circlePath.removeAllPoints()

                let width = Util.getTitleChangeChartFrame().width
                let height = Util.getTitleChangeChartFrame().height

                let size = CGFloat(3)
                let interval = size * 3

                self.circlePath.append(UIBezierPath(ovalIn: CGRect(x: width - Util.PADDING - size, y: height / 2 - size / 2, width: size, height: size)))
                self.circlePath.append(UIBezierPath(ovalIn: CGRect(x: width - Util.PADDING - size - interval - size, y: height / 2 - size / 2, width: size, height: size)))
                self.circlePath.append(UIBezierPath(ovalIn: CGRect(x: width - Util.PADDING - size - interval - size - interval - size, y: height / 2 - size / 2, width: size, height: size)))

                self.circleLayer.path = self.circlePath.cgPath
            }

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: ({
                        Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).transform = CGAffineTransform.identity
                        Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW).alpha = 1.0
                    }), completion: nil)
                }
            }


        }
    }

    class ChartView : UIView {

        var scaledTimeSeriesLayerList: [ScaledTimeSeriesLayer]!
        var chart: Chart!
        var chartGridView: GridView!
        var chartScrollView: UIScrollView!
        var chartAxisView: AxisView!
        var chartMarkerPopupView: MarkerPopupView!
        var chartMarkerLineView: UIView!
        var topShadowView: UIView!
        var chartAxisZeroLineView: UIView!
        var chartAxisZeroLineLabel: UILabel!

        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        }

        func drawChartView(chart: Chart) {
            self.chart = chart

            // Grid
            self.chartGridView = GridView()
            self.chartGridView.frame = Util.getChartGridViewFrame()
            self.chartGridView.drawGridView(chart: chart)
            self.addSubview(self.chartGridView)

            // Scroll View
            self.chartScrollView = UIScrollView()
            self.chartScrollView.showsHorizontalScrollIndicator = false
            self.chartScrollView.showsVerticalScrollIndicator = false
            self.chartScrollView.isScrollEnabled = false
            self.chartScrollView.frame = Util.getChartScrollViewFrame()
            Dispatcher.put(id: Dispatcher.CHART_SCROLL_VIEW, uiView: self.chartScrollView)
            self.addSubview(self.chartScrollView)

            self.scaledTimeSeriesLayerList = [ScaledTimeSeriesLayer]()
            for i in chart.timeSeriesList {
                let scaledTimeSeriesLayer = ScaledTimeSeriesLayer()
                self.chartScrollView.layer.addSublayer(scaledTimeSeriesLayer)
                self.scaledTimeSeriesLayerList.append(scaledTimeSeriesLayer)
            }

            self.topShadowView = UIView()
            self.addSubview(self.topShadowView)
            self.topShadowView.translatesAutoresizingMaskIntoConstraints = false
            self.topShadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.topShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.topShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.topShadowView.heightAnchor.constraint(equalToConstant: Util.SHADOW_HEIGHT).isActive = true

//            // Axis
            self.chartAxisView = AxisView()
            self.chartAxisView.drawAxisView(chart: chart)
            self.chartScrollView.addSubview(self.chartAxisView)

            // Axis Line
            self.chartAxisZeroLineView = UIView()
            self.addSubview(self.chartAxisZeroLineView)
            self.chartAxisZeroLineLabel = UILabel()
            self.chartAxisZeroLineLabel.font = self.chartAxisZeroLineLabel.font.withSize(12)
            self.chartAxisZeroLineLabel.textAlignment = .left
            self.chartAxisZeroLineLabel.text = String(0)
            self.chartAxisZeroLineLabel.sizeToFit()
            self.addSubview(self.chartAxisZeroLineLabel)

            // Marker
            self.chartMarkerPopupView = MarkerPopupView()
            self.chartMarkerPopupView.layer.cornerRadius = 4.0
            self.chartMarkerPopupView.drawMarkerPopup(chart: chart, date: chart.timeSeriesList.first!.x.first!)
            Dispatcher.put(id: Dispatcher.CHART_MARKER_POPUP_VIEW, uiView: self.chartMarkerPopupView)
            self.addSubview(self.chartMarkerPopupView)

            self.chartMarkerLineView = UIView()
            Dispatcher.put(id: Dispatcher.CHART_MARKER_LINE_VIEW, uiView: self.chartMarkerLineView)
            self.addSubview(self.chartMarkerLineView)

        }
        func renderChartView(chart: Chart, animated: Bool = true) {
            self.chart = chart


            self.chartGridView.renderGridView(chart: chart)
            for (i, e) in chart.timeSeriesList.enumerated() {
                self.scaledTimeSeriesLayerList[i].renderTimeSeries(chart: chart, timeSeries: e, animated: animated)
                (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentSize = CGSize(width: e.width, height: Util.getChartScrollViewFrame().size.height)
            }
            (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset = CGPoint(x: CGFloat(((Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.origin.x - Util.PADDING) / (Util.getSlideViewFrame().size.width - 2 * Util.PADDING)) * (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentSize.width), y: 0.0)


            self.chartAxisView.renderAxisView(chart: chart)
            self.chartMarkerPopupView.renderMarkerPopupView(chart: chart)

            self.chartAxisZeroLineView.frame = CGRect(x: Util.PADDING, y: Util.getChartScrollViewFrame().origin.y + Util.getChartAxisViewFrame().origin.y, width: Util.getChartAxisLineViewFrame(contentSize: self.chartAxisView.frame.size.width).width, height: Util.getChartAxisLineViewFrame(contentSize: self.chartAxisView.frame.size.width).height)

            self.chartAxisZeroLineView.backgroundColor = Util.getLegendDivideViewBackgroundColor()

            self.chartAxisZeroLineLabel.frame = CGRect(x: Util.PADDING, y: Util.getChartScrollViewFrame().origin.y + Util.getChartAxisViewFrame().origin.y - self.chartAxisZeroLineLabel.frame.height, width: self.chartAxisZeroLineLabel.frame.width, height: self.chartAxisZeroLineLabel.frame.height)
            self.chartAxisZeroLineLabel.textColor = Util.getChartAxisLabelColor()

            self.backgroundColor = Util.getViewBackground()
            self.topShadowView.backgroundColor = Util.getShadowViewBackground()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        class AxisView : UIView {

            var chart: Chart!
            var axisLabelContainerView: UIView!
            var axisLabelList: [UILabel]!
            var visibleAxisLabelList: [UILabel]!
            var visibleAxisDateList: [Date]!

            func drawAxisView(chart: Chart) {
                self.chart = chart


                self.axisLabelContainerView = UIView()
                self.addSubview(self.axisLabelContainerView)

                // x data
                let x = chart.timeSeriesList.first!.x
                // Date format
                let df = DateFormatter()
                df.dateFormat = "MMM d"

                var labelWidth = CGFloat(0.0)
                self.axisLabelList = [UILabel]()
                for i in x {
                    let label = UILabel()
                    label.textColor = Util.getChartAxisLabelColor()
                    label.font = label.font.withSize(11)
                    label.textAlignment = .center
                    label.text = df.string(from: i)
                    label.sizeToFit()
                    label.alpha = 0.0
                    labelWidth = max(labelWidth, label.frame.size.width)
                    self.axisLabelList.append(label)
                    self.axisLabelContainerView.addSubview(label)
                }
                self.visibleAxisLabelList = [UILabel]()
                self.visibleAxisDateList = [Date]()
            }

            func renderAxisView(chart: Chart) {
                self.frame = Util.getChartAxisViewFrame(contentSize: (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentSize.width)

                self.axisLabelContainerView.frame = Util.getChartAxisLabelContainerViewFrame(contentSize: self.frame.size.width)


                // Size of label
                var labelWidth = CGFloat(0.0)
                for i in self.axisLabelList {
                    labelWidth = max(labelWidth, i.frame.size.width)
                }
                var abscissa = [CGFloat]()
                var width = CGFloat(0)
                var x = [Date]()
                for i in chart.timeSeriesList {
                    abscissa = i.abscissa
                    width = i.width
                    x = i.x
                }
                var startTickIndex = 0
                for i in abscissa {
                    if i > labelWidth / 2 {
                        break
                    }
                    startTickIndex = startTickIndex + 1
                }



                width = Util.getChartScrollViewFrame().size.width
                var tickCount = 0
                for i in abscissa {
                    if i > width {
                        break
                    }
                    tickCount = tickCount + 1
                }

                var nextAxisLabelList = [UILabel]()
                var nextAxisDateList = [Date]()
                let tickInterval = Int(round(CGFloat(tickCount) / (Util.getChartScrollViewFrame().size.width / (labelWidth * 1.48))))
                for (i, e) in self.axisLabelList.enumerated() {
                    e.frame = CGRect(origin: CGPoint(x: abscissa[i] - e.frame.size.width / 2, y: 0.0), size: CGSize(width: e.frame.size.width, height: Util.getChartAxisLabelContainerViewFrame().size.height))
                    if i < startTickIndex {
//                        e.isHidden = true
                        continue
                    }
                    if (i - startTickIndex) % tickInterval == 0 {

                        nextAxisLabelList.append(e)
                        nextAxisDateList.append(x[i])
//                        e.isHidden = false
                    } else {
//                        e.isHidden = true
                    }
                }
                if self.visibleAxisDateList.count != nextAxisDateList.count || self.visibleAxisDateList.sorted() != nextAxisDateList.sorted() {
                    for i in self.visibleAxisLabelList {
                        UIView.animate(withDuration: 0.05, animations: {
                            i.alpha = 0.0
                        })
//                        i.alpha = 0.0
                    }
                    for i in nextAxisLabelList {
                        UIView.animate(withDuration: 0.2, animations: {
                            i.alpha = 1.0
                        })
                    }
                }
                self.visibleAxisLabelList = nextAxisLabelList
                self.visibleAxisDateList = nextAxisDateList


//                let tickCount = abscissa.count - (startTickIndex + 1) * 2
//                var tickIntervalApproximation = CGFloat(tickCount) / (width / (labelWidth * 1.5))
//                var tickInterval = Int(round(tickIntervalApproximation))
////                print(tickInterval)
//                for i in (tickInterval)..<tickCount {
//                    if i % 2 == 0 {
//                        tickInterval = i
//                        break
//                    }
//                }
////                print(tickInterval)
//
////                print(CGFloat(tickCount) / (width / (labelWidth * 1.48)))
//
//                for (i, e) in self.axisLabelList.enumerated() {
//                    if i < startTickIndex || i > abscissa.count - startTickIndex - 1 {
//                        e.isHidden = true
//                        continue
//                    }
//                    e.frame = CGRect(origin: CGPoint(x: abscissa[i] - e.frame.size.width / 2, y: 0.0), size: CGSize(width: e.frame.size.width, height: Util.getChartAxisLabelContainerViewFrame().size.height))
//                    if (i - startTickIndex) % tickInterval == 0 {
//                        e.isHidden = false
//                        e.alpha = 1 - abs(tickIntervalApproximation - CGFloat(tickInterval))
//
//                        continue
//                    }
//                    if (i - startTickIndex) % (tickInterval + 2) == 0 {
//                        e.isHidden = false
//                        e.alpha = abs(tickIntervalApproximation - CGFloat(tickInterval))
//
//                        continue
//                    }
//                    e.isHidden = true
//                }



            }
        }

        class GridView : UIView {
            var chart: Chart!
            var gridLineViewList: [UIView]!
            var gridLabelList: [UILabel]!
            var previousTickRange: CGFloat!


            func drawGridView(chart: Chart) {

            }

            var asd = false

            func renderGridView(chart: Chart) {

                self.chart = chart

                var step = CGFloat(0.0)
                for i in chart.timeSeriesList {
                    step = CGFloat(i.width) / CGFloat(i.y.count - 1)
                }
                var minValue = Float(0.0)
                var maxValue = Float(0.0)

                for i in chart.timeSeriesList {
                    if i.hidden {
                        continue
                    }
//                    maxValue = max(maxValue, i.y.max()!)
                    for (j, e) in i.y.enumerated() {
                        if CGFloat(j) * step >= (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset.x && (CGFloat(j) * step) <= ((Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset.x + (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).frame.size.width) {
                            maxValue = max(maxValue, i.y[j])
                        }

                    }
                    minValue = min(minValue, i.y.min()!)
                }

                let difference = maxValue - minValue;
                let tickCount = 6;
                var tickRange = CGFloat(ceilf((difference / Float(tickCount - 1)) / pow(10, ceilf(log10(difference / Float(tickCount - 1)) - 1))) * pow(10, ceilf(log10(difference / Float(tickCount - 1)) - 1)));

                if(tickRange.isNaN) {
                    tickRange = 1.0
                }
                // TODO:
                if(self.previousTickRange == tickRange) {
                    for i in self.gridLabelList {
                        i.textColor = Util.getChartAxisLabelColor()
                    }
                    for i in self.gridLineViewList {
                        i.backgroundColor = Util.getChartGridColor()
                    }
                    return
                }
                self.previousTickRange = tickRange

                var previousGridLineViewList = [UIView]()
                var previousGridLabelList = [UILabel]()
                if(self.gridLineViewList != nil && self.gridLabelList != nil) {
                    previousGridLineViewList = self.gridLineViewList!
                    previousGridLabelList = self.gridLabelList!
                }

                var labelHeight = CGFloat(0.0)
                self.gridLabelList = [UILabel]()
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                nf.groupingSeparator = " "
                for i in 1..<tickCount {
                    let label = UILabel()
                    label.textColor = Util.getChartAxisLabelColor()
                    label.font = label.font.withSize(12)
                    label.textAlignment = .left
                    label.text = nf.string(from: NSNumber(value: Int(round(CGFloat(i) * tickRange))))//String(Int(round(CGFloat(i) * tickRange)))
                    label.sizeToFit()
                    labelHeight = label.frame.size.height
                    self.gridLabelList.append(label)
                }
                labelHeight = labelHeight * 1.4

                let height = Util.getChartGridViewFrame().size.height
                let width = Util.getChartGridViewFrame().size.width


                let interval = (height - labelHeight) / CGFloat(tickCount - 1)


                let scale = interval / tickRange
                var increase = true
                for i in chart.timeSeriesList {
                    increase = i.scale > scale
                }
                for i in chart.timeSeriesList {
                    i.scale = scale
                }

                self.gridLineViewList = [UIView]()
                for (i, e) in self.gridLabelList.enumerated() {
                    let gridLineView = UIView()
                    gridLineView.backgroundColor = Util.getChartGridColor()
                    gridLineView.frame = CGRect(origin: CGPoint(x: 0.0, y: height - CGFloat(i + 1) * interval), size: CGSize(width: width, height: 0.5))
                    self.addSubview(gridLineView)
                    e.frame = CGRect(origin: CGPoint(x: 0.0, y: gridLineView.frame.maxY - labelHeight), size: CGSize(width: e.frame.size.width, height: labelHeight))
                    self.addSubview(e)
                    self.gridLineViewList.append(gridLineView)
                }

                for (i, e) in self.gridLineViewList.enumerated() {
                    let dy = CGFloat(interval / 2 * (increase ? -1 : 1))
                    self.gridLineViewList[i].alpha = 0.0
                    self.gridLineViewList[i].transform = self.gridLineViewList[i].transform.translatedBy(x: 0.0, y: dy)
                    self.gridLabelList[i].alpha = 0.0
                    self.gridLabelList[i].transform = self.gridLabelList[i].transform.translatedBy(x: 0.0, y: dy)
                    Animator.animate(withDuration: 0.2, animations: {
                        self.gridLineViewList[i].alpha = 1.0
                        self.gridLineViewList[i].transform = self.gridLineViewList[i].transform.translatedBy(x: 0.0, y: -dy)
                        self.gridLabelList[i].alpha = 1.0
                        self.gridLabelList[i].transform = self.gridLabelList[i].transform.translatedBy(x: 0.0, y: -dy)
                    })
                }


                for (i, e) in previousGridLineViewList.enumerated() {
                    let dy = CGFloat(interval / 2 * (increase ? -1 : 1))
                    Animator.animate(withDuration: 0.2, animations: {
                        previousGridLineViewList[i].alpha = 0.0
                        previousGridLineViewList[i].transform = previousGridLineViewList[i].transform.translatedBy(x: 0.0, y: -dy)
                        previousGridLabelList[i].alpha = 0.0
                        previousGridLabelList[i].transform = previousGridLabelList[i].transform.translatedBy(x: 0.0, y: -dy)
                    }, completion: { (finished: Bool) in
                        for i in previousGridLineViewList {
                            i.removeFromSuperview()
                        }
                        for i in previousGridLabelList {
                            i.removeFromSuperview()
                        }
                    })
                }


            }

        }

        class MarkerPopupView : UIView {

            var chart: Chart!
            var date: Date!
            var dayMonthLabel: UILabel!
            var yearLabel: UILabel!
            var dataLabelList: [UILabel]!
            var maxLabelWidth: CGFloat!

            var markerViewList: [UIView]!
            var mainIndex: Int!

            func drawMarkerPopup(chart: Chart, date: Date) {
                self.chart = chart

                self.dayMonthLabel = UILabel()
                self.dayMonthLabel.font = self.dayMonthLabel.font.withSize(14)
                self.dayMonthLabel.textAlignment = .left
                self.dayMonthLabel.frame = Util.getChartMarkerDayMonthLabelFrame()
                self.addSubview(self.dayMonthLabel)

                self.yearLabel = UILabel()
                self.yearLabel.font = self.yearLabel.font.withSize(14)
                self.yearLabel.textAlignment = .left
                self.yearLabel.frame = Util.getChartMarkerYearLabelFrame()
                self.addSubview(self.yearLabel)

                self.markerViewList = [UIView]()

                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                nf.groupingSeparator = " "
                self.dataLabelList = [UILabel]()
                self.maxLabelWidth = 0
                for i in chart.timeSeriesList {
                    let label = UILabel()
                    label.textColor = i.color
                    label.font = label.font.withSize(14)
                    label.textAlignment = .right
                    for j in i.y {
                        label.text = nf.string(from: NSNumber(value: j))
                        label.sizeToFit()
                        self.maxLabelWidth = max(self.maxLabelWidth!, label.frame.width)
                    }

                    label.isHidden = true
                    self.dataLabelList.append(label)
                    self.addSubview(label)

                    let marker = UIView()
                    marker.layer.cornerRadius = 4
                    marker.backgroundColor = i.color
                    self.markerViewList.append(marker)
                    Dispatcher.get(id: Dispatcher.CHART_VIEW).addSubview(marker)
                }


//                let stackView = UIStackView()
//                stackView.axis = .vertical
//                stackView.distribution = .fillEqually
//                stackView.alignment = .fill
//                stackView.translatesAutoresizingMaskIntoConstraints = false
//                stackView.backgroundColor = UIColor.green.withAlphaComponent(0.1)
//                self.addSubview(stackView)
//                stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//                stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//                for i in chart.timeSeriesList {
//                    for (j, e) in i.x.enumerated() {
//                        if e == date {
//                            let label = UILabel()
//                            label.textColor = i.color
//                            label.font = label.font.withSize(14)
//                            label.textAlignment = .right
//                            label.text = String(i.y[j])
//                            label.sizeToFit()
//                            stackView.addArrangedSubview(label)
//                        }
//                    }
//                }



            }



            func renderMarkerPopupView(chart: Chart) {



                var x = [Date]()
                var abscissa = [CGFloat]()
                for i in self.chart.timeSeriesList {
                    x = i.x
                    abscissa = i.abscissa
                }
                let contentOffset = (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset.x

                var startIndex = 0
                for (i, e) in abscissa.enumerated() {
                    if i == 0 {
                        continue
                    }
                    if abscissa[i - 1] <= contentOffset && abscissa[i] >= contentOffset {
                        startIndex = i - 1
                    }
                }




                let interval = abscissa.last! / CGFloat(abscissa.count)


                if self.date == nil {
                    let i = startIndex + Int(round(0.5 * Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW).frame.width / interval))
                    self.mainIndex = i
                    self.date = x[i]
                    Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame = CGRect(x: abscissa[i] - contentOffset + Util.PADDING, y: self.frame.maxY, width: 1.0, height: Util.getChartScrollViewFrame().origin.y + Util.getChartAxisViewFrame().origin.y - Util.getChartMarkerPopupViewFrame(count: chart.timeSeriesList.count).maxY)

                }

                for i in startIndex..<abscissa.count {
                    if interval / 2 >= abs((Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).center.x - Util.PADDING) - (abscissa[i] - (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset.x)) {
                        for j in self.chart.timeSeriesList {
                            self.mainIndex = i
                            self.date = j.x[i]
                            break
                        }
                    }
                }

                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                nf.groupingSeparator = " "
                var notHidden = 0
                var previousFrame = CGRect.zero
                for (i, e) in chart.timeSeriesList.enumerated() {
                    self.dataLabelList[i].text = nf.string(from: NSNumber(value: e.y[self.mainIndex]))
                    self.dataLabelList[i].isHidden = e.hidden
                    self.markerViewList[i].isHidden = e.hidden
                    if !e.hidden {
                        notHidden = notHidden + 1
                        self.dataLabelList[i].frame = CGRect(x: self.dayMonthLabel.frame.maxX, y: previousFrame.maxY, width: maxLabelWidth, height: self.dayMonthLabel.frame.height)
                        Dispatcher.get(id: Dispatcher.CHART_VIEW).bringSubviewToFront(self.markerViewList[i])
                        self.markerViewList[i].frame = CGRect(x: e.abscissa[self.mainIndex] - contentOffset + Util.PADDING - 8 / 2, y: Dispatcher.get(id: Dispatcher.CHART_VIEW).frame.height - Util.getChartAxisViewFrame().height - e.ordinate[self.mainIndex], width: 8, height: 8)
                        previousFrame = self.dataLabelList[i].frame
                    }
                }

                let width = self.dayMonthLabel.frame.maxX + maxLabelWidth + self.dayMonthLabel.frame.origin.x// Util.getChartMarkerPopupViewFrame().width
                let height = Util.getChartMarkerPopupViewFrame(count: notHidden).height

                self.dayMonthLabel.textColor = Util.getChartMarkerPopupLabelColor()
                self.yearLabel.textColor = Util.getChartMarkerPopupLabelColor()
                self.backgroundColor = Util.getChartMarkerPopupViewBackgroundColor().withAlphaComponent(0.5)

                let df = DateFormatter()

                df.dateFormat = "MMM d"
                self.dayMonthLabel.text = df.string(from: self.date)

                df.dateFormat = "yyyy"
                self.yearLabel.text = df.string(from: self.date)



                if Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).center.x + width / 2 >= Util.getChartViewFrame().maxX - Util.PADDING / 2 {
                    self.frame = CGRect(x: Util.getChartViewFrame().maxX - Util.PADDING / 2 - width, y: Util.getChartMarkerPopupViewFrame().origin.y, width: width, height: height)
                } else if Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).center.x - width / 2 <= Util.PADDING / 2 {
                    self.frame = CGRect(x: Util.PADDING / 2, y: Util.getChartMarkerPopupViewFrame().origin.y, width: width, height: height)
                } else {
                    self.frame = CGRect(x: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).center.x - width / 2, y: Util.getChartMarkerPopupViewFrame().origin.y, width: width, height: height)
                }

                Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame = CGRect(x: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.origin.x, y: self.frame.maxY, width: 1.0, height: Util.getChartScrollViewFrame().origin.y + Util.getChartAxisViewFrame().origin.y - self.frame.maxY)
                Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).backgroundColor = Util.getLegendDivideViewBackgroundColor()
            }

            var currentPoint: CGPoint!

            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.currentPoint = touch.location(in: self)
                }
            }

            override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.touchesPerformed(touch: touch)
                    self.currentPoint = touch.location(in: self)
                }
            }

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.touchesPerformed(touch: touch)
                    self.currentPoint = touch.location(in: self)
                }
            }

            func touchesPerformed(touch: UITouch) {
                let nextPoint = touch.location(in: self)
                if Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.offsetBy(dx: nextPoint.x - self.currentPoint.x, dy: 0.0).maxX >= Util.getChartViewFrame().maxX - Util.PADDING {
                    Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame = CGRect(x: Util.getChartViewFrame().maxX - Util.PADDING, y: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.origin.y, width: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.size.width, height: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.size.height)
                } else if Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.offsetBy(dx: nextPoint.x - self.currentPoint.x, dy: 0.0).origin.x <= Util.PADDING {
                    Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame = CGRect(x: Util.PADDING, y: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.origin.y, width: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.size.width, height: Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.size.height)
                } else {
                    Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame = Dispatcher.get(id: Dispatcher.CHART_MARKER_LINE_VIEW).frame.offsetBy(dx: nextPoint.x - self.currentPoint.x, dy: 0.0)
                }
                self.renderMarkerPopupView(chart: self.chart)
            }

        }

        class ScaledTimeSeriesLayer : CAShapeLayer {

            var chart: Chart!
            var timeSeries: TimeSeries!
            var curvePath: UIBezierPath!
            var curveOpacity: Float!
            var previousScale: CGFloat!

            func renderTimeSeries(chart: Chart, timeSeries: TimeSeries, animated: Bool) {


                self.chart = chart
                self.timeSeries = timeSeries
                var previousCurvePath = self.curvePath
                self.curvePath = UIBezierPath()


                self.lineWidth = 2.0
                self.strokeColor = self.timeSeries.color.cgColor

                let height = Util.getChartScrollViewFrame().size.height
                let width = timeSeries.width

//                if self.previousScale == timeSeries.scale {
//                    return
//                }

                var y = [CGFloat]()
                let interval = width / CGFloat(timeSeries.y.count - 1)
                var abscissa = [CGFloat]()
                let adjustment = Util.getChartAxisViewFrame().size.height
                for i in timeSeries.y {
                    if timeSeries.hidden {
                        y.append(height - adjustment)
                    } else {
                        y.append(CGFloat(i) * (animated ? timeSeries.scale : self.previousScale))
                    }
                }
                if animated {
                    self.previousScale = timeSeries.scale
                }

                self.curvePath.move(to: CGPoint(x: 0, y: height - adjustment - y.first!))
                abscissa.append(CGFloat(0.0))
                for (i, e) in y.dropFirst().enumerated() {
                    self.curvePath.addLine(to: CGPoint(x: CGFloat(i + 1) * interval, y: height - adjustment - e))
                    abscissa.append(CGFloat(i + 1) * interval)
                    self.curvePath.move(to: CGPoint(x: CGFloat(i + 1) * interval, y: height - adjustment - e))
                }
                timeSeries.abscissa = abscissa
                timeSeries.ordinate = y

                let previousCurvePathNil = previousCurvePath == nil
                if previousCurvePath == nil {
                    previousCurvePath = UIBezierPath()

                    previousCurvePath?.move(to: CGPoint(x: 0, y: height - adjustment))
                    for (i, e) in y.dropFirst().enumerated() {
                        previousCurvePath?.addLine(to: CGPoint(x: CGFloat(i + 1) * interval, y: height - adjustment))
                        previousCurvePath?.move(to: CGPoint(x: CGFloat(i + 1) * interval, y: height - adjustment))
                    }
//                    self.path = previousCurvePath?.cgPath
                }

                if self.timeSeries.hidden {
                    self.curveOpacity = 0.0
                } else {
                    self.curveOpacity = 1.0
                }

//                let springPathAnimation = CASpringAnimation(keyPath: "path")
//                springPathAnimation.damping = 3
//                springPathAnimation.fromValue = previousCurvePath?.cgPath
//                springPathAnimation.toValue = self.curvePath.cgPath
//                springPathAnimation.duration = springPathAnimation.settlingDuration
//                springPathAnimation.fillMode = CAMediaTimingFillMode.forwards;
//                springPathAnimation.isRemovedOnCompletion = false;

                let pathAnimation = CABasicAnimation(keyPath: "path")
                pathAnimation.fromValue = previousCurvePathNil ? previousCurvePath?.cgPath : self.presentation()?.path
                pathAnimation.toValue = self.curvePath.cgPath
                pathAnimation.duration = 0.2
                pathAnimation.fillMode = CAMediaTimingFillMode.forwards;
                pathAnimation.isRemovedOnCompletion = false;

                let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                opacityAnimation.fromValue = self.presentation()?.opacity
                opacityAnimation.toValue = self.curveOpacity
                opacityAnimation.duration = 0.2
                opacityAnimation.fillMode = CAMediaTimingFillMode.forwards;
                opacityAnimation.isRemovedOnCompletion = false;

                if(animated) {
                    self.add(pathAnimation, forKey: pathAnimation.keyPath)
                    self.add(opacityAnimation, forKey: opacityAnimation.keyPath)
                } else {



//                    let pathAnimation = CABasicAnimation(keyPath: "path")
//                    var k = UIBezierPath(cgPath: self.presentation()!.path!)
//                    print(timeSeries.width / self.previousScale)
//                    k.apply(CGAffineTransform(scaleX: 10, y: 1.0))
//                    pathAnimation.fromValue = k.cgPath
//                    pathAnimation.toValue = self.curvePath.cgPath
//                    pathAnimation.duration = 0.2
//                    pathAnimation.fillMode = CAMediaTimingFillMode.forwards;
//                    pathAnimation.isRemovedOnCompletion = false;
//                    self.add(pathAnimation, forKey: pathAnimation.keyPath)
                    self.removeAllAnimations()
//                    self.path = k.cgPath


                }
                self.path = self.curvePath.cgPath
                self.opacity = self.curveOpacity
            }
        }
    }

    class SlideView : UIView {

        var chart: Chart!
        var timeSeriesLayerList: [TimeSeriesLayer]!
        var leftFadeView: UIView!
        var rightFadeView: UIView!
        var sliderView: SliderView!

        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        }

        func drawSlideView(chart: Chart) {
            self.chart = chart

            self.timeSeriesLayerList = [TimeSeriesLayer]()
            for i in chart.timeSeriesList {
                let timeSeriesLayer = TimeSeriesLayer()
                self.layer.addSublayer(timeSeriesLayer)
                self.timeSeriesLayerList.append(timeSeriesLayer)
            }

            self.sliderView = SliderView()
            self.sliderView.frame = Util.getSlideSliderViewFrame()
            self.sliderView.drawSliderView(chart: chart)
            Dispatcher.put(id: Dispatcher.SLIDE_SLIDER_VIEW, uiView: self.sliderView)
            self.addSubview(self.sliderView)

            self.leftFadeView = LeftFadeView()
            self.leftFadeView.frame = Util.getSlideLeftFadeViewFrame()
            Dispatcher.put(id: Dispatcher.SLIDE_LEFT_FADE_VIEW, uiView: self.leftFadeView)
            self.addSubview(self.leftFadeView)

            self.rightFadeView = RightFadeView()
            self.rightFadeView.frame = Util.getSlideRightFadeViewFrame()
            Dispatcher.put(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW, uiView: self.rightFadeView)
            self.addSubview(self.rightFadeView)


        }

        func renderSlideView(chart: Chart) {
            let dispatcherSlideSliderViewFrame = Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame
            for i in chart.timeSeriesList {
                i.width = Util.getChartScrollViewFrame().size.width / (dispatcherSlideSliderViewFrame.size.width / Util.getSlideControlViewFrame().size.width)
            }

            for (i, e) in chart.timeSeriesList.enumerated() {
                self.timeSeriesLayerList[i].renderTimeSeries(chart: chart, timeSeries: e)
            }

            self.backgroundColor = Util.getViewBackground()
            self.sliderView.renderSliderView(chart: chart)
            self.leftFadeView.backgroundColor = Util.getContainerViewBackground().withAlphaComponent(0.5)
            self.rightFadeView.backgroundColor = Util.getContainerViewBackground().withAlphaComponent(0.5)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        class LeftFadeView : UIView {

            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.touchesPerformed(touch: touch)
                }
            }

            override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
//                    self.touchesPerformed(touch: touch)
                }
            }

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
//                    self.touchesPerformed(touch: touch)
                }
            }

            func touchesPerformed(touch: UITouch) {
                let currentPoint = touch.location(in: self)
                let slideSliderViewFrame = Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame
                let adjustedCurrentPoint = CGPoint(x: currentPoint.x + Util.PADDING, y: currentPoint.y)
                let x = max(Util.getSlideLeftFadeViewFrame().origin.x, adjustedCurrentPoint.x - slideSliderViewFrame.size.width / 2)
                Animator.animate(withDuration: 0.2, animations: {
                    Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame = CGRect(x: x, y: Util.getSlideSliderViewFrame().origin.y, width: slideSliderViewFrame.width, height: Util.getSlideSliderViewFrame().size.height)
                    Dispatcher.get(id: Dispatcher.SLIDE_LEFT_FADE_VIEW).frame = Util.getSlideLeftFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)
                    Dispatcher.get(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW).frame = Util.getSlideRightFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)

                    (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset = CGPoint(x: CGFloat(((x - Util.PADDING) / (Util.getSlideViewFrame().size.width - 2 * Util.PADDING)) * (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentSize.width), y: 0.0)
                    (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                    (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart)
                })
            }
        }

        class RightFadeView : UIView {

            override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.touchesPerformed(touch: touch)
                }
            }

            override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
//                    self.touchesPerformed(touch: touch)
                }
            }

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
//                    self.touchesPerformed(touch: touch)
                }
            }

            func touchesPerformed(touch: UITouch) {
                let currentPoint = touch.location(in: self)
                let slideSliderViewFrame = Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame
                let adjustedCurrentPoint = CGPoint(x: currentPoint.x + Util.PADDING + slideSliderViewFrame.maxX, y: currentPoint.y)
                let x = min(adjustedCurrentPoint.x + slideSliderViewFrame.size.width / 2, Util.getSlideControlViewFrame().origin.x + Util.getSlideControlViewFrame().size.width) - slideSliderViewFrame.size.width
                Animator.animate(withDuration: 0.2, animations: {
                    Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame = CGRect(x: x, y: Util.getSlideSliderViewFrame().origin.y, width: slideSliderViewFrame.width, height: Util.getSlideSliderViewFrame().size.height)
                    Dispatcher.get(id: Dispatcher.SLIDE_LEFT_FADE_VIEW).frame = Util.getSlideLeftFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)
                    Dispatcher.get(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW).frame = Util.getSlideRightFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)

                    (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentOffset = CGPoint(x: CGFloat(((x - Util.PADDING) / (Util.getSlideViewFrame().size.width - 2 * Util.PADDING)) * (Dispatcher.get(id: Dispatcher.CHART_SCROLL_VIEW) as! UIScrollView).contentSize.width), y: 0.0)
                    (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                    (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart)
                })
            }
        }

        class SliderView : UIView {

            var chart: Chart!
            var leftArrowView: UIView!
            var leftArrowLayer: ArrowLayer!
            var rightArrowView: UIView!
            var rightArrowLayer: ArrowLayer!
            var centerWindowView: UIView!
            var topBorderView: UIView!
            var bottomBorderView: UIView!

            func drawSliderView(chart: Chart) {
                self.chart = chart

                self.leftArrowView = LeftArrowView()
                self.leftArrowView.layer.cornerRadius = 4.0
                self.leftArrowView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                Dispatcher.put(id: Dispatcher.SLIDE_LEFT_ARROW_VIEW, uiView: self.leftArrowView)
                self.addSubview(self.leftArrowView)
                self.leftArrowView.translatesAutoresizingMaskIntoConstraints = false
                self.leftArrowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                self.leftArrowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                self.leftArrowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
                self.leftArrowView.widthAnchor.constraint(equalToConstant: Util.getSlideLeftArrowViewFrame().width).isActive = true

                self.leftArrowLayer = ArrowLayer()
                self.leftArrowView.layer.addSublayer(self.leftArrowLayer)

                self.rightArrowView = RightArrowView()
                self.rightArrowView.layer.cornerRadius = 4.0
                self.rightArrowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                Dispatcher.put(id: Dispatcher.SLIDE_RIGHT_ARROW_VIEW, uiView: self.rightArrowView)
                self.addSubview(self.rightArrowView)
                self.rightArrowView.translatesAutoresizingMaskIntoConstraints = false
                self.rightArrowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                self.rightArrowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                self.rightArrowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
                self.rightArrowView.widthAnchor.constraint(equalToConstant: Util.getSlideRightArrowViewFrame().width).isActive = true

                self.rightArrowLayer = ArrowLayer()
                self.rightArrowView.layer.addSublayer(self.rightArrowLayer)

                self.centerWindowView = CenterWindowView()
                self.addSubview(self.centerWindowView)
                self.centerWindowView.translatesAutoresizingMaskIntoConstraints = false
                self.centerWindowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                self.centerWindowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                self.centerWindowView.leadingAnchor.constraint(equalTo: self.leftArrowView.trailingAnchor).isActive = true
                self.centerWindowView.trailingAnchor.constraint(equalTo: self.rightArrowView.leadingAnchor).isActive = true

                self.topBorderView = UIView()
                self.centerWindowView.addSubview(self.topBorderView)
                self.topBorderView.translatesAutoresizingMaskIntoConstraints = false
                self.topBorderView.topAnchor.constraint(equalTo: self.centerWindowView.topAnchor).isActive = true
                self.topBorderView.leadingAnchor.constraint(equalTo: self.centerWindowView.leadingAnchor).isActive = true
                self.topBorderView.trailingAnchor.constraint(equalTo: self.centerWindowView.trailingAnchor).isActive = true
                self.topBorderView.heightAnchor.constraint(equalToConstant: Util.SLIDE_VIEW_PADDING).isActive = true

                self.bottomBorderView = UIView()
                self.centerWindowView.addSubview(self.bottomBorderView)
                self.bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
                self.bottomBorderView.bottomAnchor.constraint(equalTo: self.centerWindowView.bottomAnchor).isActive = true
                self.bottomBorderView.leadingAnchor.constraint(equalTo: self.centerWindowView.leadingAnchor).isActive = true
                self.bottomBorderView.trailingAnchor.constraint(equalTo: self.centerWindowView.trailingAnchor).isActive = true
                self.bottomBorderView.heightAnchor.constraint(equalToConstant: Util.SLIDE_VIEW_PADDING).isActive = true
            }

            func renderSliderView(chart: Chart) {
                self.chart = chart
                self.leftArrowLayer.renderArrow(left: true)
                self.rightArrowLayer.renderArrow(left: false)
                self.leftArrowView.backgroundColor = Util.getSlideSliderColor()
                self.rightArrowView.backgroundColor = Util.getSlideSliderColor()
                self.topBorderView.backgroundColor = Util.getSlideSliderColor()
                self.bottomBorderView.backgroundColor = Util.getSlideSliderColor()
            }

            class ArrowLayer : CAShapeLayer {

                var arrowPath: UIBezierPath!
                var curveStroke: Float!

                func renderArrow(left: Bool) {
                    self.arrowPath = UIBezierPath()

                    self.lineWidth = 2.0
                    self.strokeColor = Util.getSlideArrowViewColor().cgColor

                    let height = left ? Util.getSlideLeftArrowViewFrame().height : Util.getSlideRightArrowViewFrame().height
                    let width = left ? Util.getSlideLeftArrowViewFrame().width : Util.getSlideRightArrowViewFrame().width

                    let arrowWidth = width / 3
                    let arrowHeight = height / 4
                    self.arrowPath.move(to: CGPoint(x: width / 2 + (left ? 1 : -1) * arrowWidth / 2, y: height / 2 - arrowHeight / 2))
                    self.arrowPath.addLine(to: CGPoint(x: width / 2 + (left ? -1 : 1) * arrowWidth / 2, y: height / 2))
                    self.arrowPath.move(to: CGPoint(x: width / 2 + (left ? -1 : 1) * arrowWidth / 2, y: height / 2))
                    self.arrowPath.addLine(to: CGPoint(x: width / 2 + (left ? 1 : -1) * arrowWidth / 2, y: height / 2 + arrowHeight / 2))


                    self.path = self.arrowPath.cgPath
                }
            }

            class LeftArrowView : UIView {

                var currentPoint: CGPoint!

                override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.movePerformed(touch: touch)
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.releasePerformed(touch: touch)
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                func movePerformed(touch: UITouch) {
                    let nextPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))

                    let dx = nextPoint.x - self.currentPoint.x
                    var x = max(Util.getSlideLeftFadeViewFrame().origin.x, Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.origin.x + dx)
                    x = min(x, Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.maxX - Util.getSlideLeftArrowViewFrame().width - Util.SLIDE_WINDOW_MIN_SIZE - Util.getSlideRightArrowViewFrame().width)
                    let width = Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.maxX - x

                    Dispatcher.perform(action: {
                        Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame = CGRect(x: x, y: Util.getSlideSliderViewFrame().origin.y, width: width, height: Util.getSlideSliderViewFrame().size.height)
                        Dispatcher.get(id: Dispatcher.SLIDE_LEFT_FADE_VIEW).frame = Util.getSlideLeftFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)
                        Dispatcher.get(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW).frame = Util.getSlideRightFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)

                        (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                        (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart, animated: false)
                    })
                }

                func releasePerformed(touch: UITouch) {
                    Dispatcher.perform(action: {
                        (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                        (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart)
                    })
                }
            }

            class RightArrowView : UIView {

                var currentPoint: CGPoint!
                var lastRenderTime: TimeInterval!

                override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.movePerformed(touch: touch)
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.releasePerformed(touch: touch)
                        self.currentPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))
                    }
                }

                func movePerformed(touch: UITouch) {
                    let nextPoint = touch.location(in: Dispatcher.get(id: Dispatcher.SLIDE_VIEW))

                    let dx = nextPoint.x - self.currentPoint.x
                    var width = min(Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.size.width + dx, Util.getSlideViewFrame().size.width - Util.PADDING - Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.origin.x)
                    width = max(width, Util.getSlideLeftArrowViewFrame().width + Util.SLIDE_WINDOW_MIN_SIZE + Util.getSlideRightArrowViewFrame().width)
                    Dispatcher.perform(action: {
                        Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame = CGRect(x: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.origin.x, y: Util.getSlideSliderViewFrame().origin.y, width: width, height: Util.getSlideSliderViewFrame().size.height)
                        Dispatcher.get(id: Dispatcher.SLIDE_LEFT_FADE_VIEW).frame = Util.getSlideLeftFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)
                        Dispatcher.get(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW).frame = Util.getSlideRightFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)

                        (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                        (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart, animated: false)

                    })
                }

                func releasePerformed(touch: UITouch) {
                    Dispatcher.perform(action: {
                        (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).chart)
                        (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart)
                    })
                }
            }

            class CenterWindowView : UIView {

                var currentPoint: CGPoint!

                override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.currentPoint = touch.location(in: self)
                    }
                }

                override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.touchesPerformed(touch: touch)
                        self.currentPoint = touch.location(in: self)
                    }
                }

                override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                    if let touch = touches.first {
                        self.touchesPerformed(touch: touch)
                        self.currentPoint = touch.location(in: self)
                    }
                }

                func touchesPerformed(touch: UITouch) {
                    let nextPoint = touch.location(in: self)

                    let dx = nextPoint.x - self.currentPoint.x
                    var x = Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.origin.x + dx
                    if x < Util.getSlideLeftFadeViewFrame().origin.x {
                        x = Util.getSlideLeftFadeViewFrame().origin.x
                    }
                    if x + Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.size.width > Util.getSlideRightFadeViewFrame().maxX {
                        x = Util.getSlideRightFadeViewFrame().maxX - Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.size.width
                    }

                    Dispatcher.perform(action: {
                        Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame = CGRect(x: x, y: Util.getSlideSliderViewFrame().origin.y, width: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame.size.width, height: Util.getSlideSliderViewFrame().size.height)
                        Dispatcher.get(id: Dispatcher.SLIDE_LEFT_FADE_VIEW).frame = Util.getSlideLeftFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)
                        Dispatcher.get(id: Dispatcher.SLIDE_RIGHT_FADE_VIEW).frame = Util.getSlideRightFadeViewFrame(sliderViewFrame: Dispatcher.get(id: Dispatcher.SLIDE_SLIDER_VIEW).frame)

                        (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).chart)
                    })
                }
            }
        }

        class TimeSeriesLayer : CAShapeLayer {

            var id: String!
            var chart: Chart!
            var timeSeries: TimeSeries!
            var curvePath: UIBezierPath!
            var curveOpacity: Float!

            func renderTimeSeries(chart: Chart, timeSeries: TimeSeries) {
                self.chart = chart
                self.timeSeries = timeSeries
                var previousCurvePath = self.curvePath
                self.curvePath = UIBezierPath()

                self.lineWidth = 1.0
                self.strokeColor = self.timeSeries.color.cgColor


                var minValue = Float(0.0)
                var maxValue = Float(0.0)
                for i in chart.timeSeriesList {
                    if(i.hidden) {
                        continue
                    }
                    minValue = min(minValue, i.y.min()!)
                    maxValue = max(maxValue, i.y.max()!)
                }
                let difference = CGFloat(maxValue - minValue);

                let height = (self.superlayer!.delegate as! UIView).frame.size.height
                let width = (self.superlayer!.delegate as! UIView).frame.size.width
                let adjustment = 2 + Util.SLIDE_VIEW_PADDING
                var y = [CGFloat]()
                for i in timeSeries.y {
                    if(timeSeries.hidden) {
                        y.append(height - adjustment - Util.SLIDE_VIEW_PADDING)
                    } else {
                        y.append(CGFloat(i) / (difference / (height - 2 * adjustment)))
                    }
                }
                let interval = (width - Util.PADDING * 2) / CGFloat(y.count - 1)
                self.curvePath.move(to: CGPoint(x: Util.PADDING, y: height - adjustment - y.first!))
                for (i, e) in y.dropFirst().enumerated() {
                    self.curvePath.addLine(to: CGPoint(x: Util.PADDING + CGFloat(i + 1) * interval, y: height - adjustment - e))
                    self.curvePath.move(to: CGPoint(x: Util.PADDING + CGFloat(i + 1) * interval, y: height - adjustment - e))
                }

                if previousCurvePath == nil {
                    previousCurvePath = UIBezierPath()
                    previousCurvePath?.move(to: CGPoint(x: Util.PADDING, y: height - adjustment))
                    for (i, e) in y.enumerated() {
                        previousCurvePath?.move(to: CGPoint(x: Util.PADDING + CGFloat(i + 1) * interval, y: height - adjustment))
                        previousCurvePath?.addLine(to: CGPoint(x: Util.PADDING + CGFloat(i + 1) * interval, y: height - adjustment))
                    }
                    self.path = previousCurvePath?.cgPath
                }

                var previousCurveOpacity = self.curveOpacity

                if timeSeries.hidden {
                    self.curveOpacity = 0.0
                } else {
                    self.curveOpacity = 1.0
                }

                if previousCurveOpacity == nil {
                    previousCurveOpacity = 1.0
                }

                let pathAnimation = CABasicAnimation(keyPath: "path")
                pathAnimation.fromValue = self.presentation()?.path
                pathAnimation.toValue = self.curvePath.cgPath
                pathAnimation.duration = 0.2
                pathAnimation.fillMode = CAMediaTimingFillMode.forwards;
                pathAnimation.isRemovedOnCompletion = false;

                let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                opacityAnimation.fromValue = self.presentation()?.opacity
                opacityAnimation.toValue = self.curveOpacity
                opacityAnimation.duration = 0.2
                opacityAnimation.fillMode = CAMediaTimingFillMode.forwards;
                opacityAnimation.isRemovedOnCompletion = false;

                self.add(pathAnimation, forKey: pathAnimation.keyPath)
                self.add(opacityAnimation, forKey: opacityAnimation.keyPath)
            }
        }
    }

    class LegendView : UIView {

        var chart: Chart!
        var cellViewList: [CellView]!
        var divideViewList: [UIView]!
        var bottomShadowView: UIView!

        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        }

        func drawLegendView(chart: Chart) {
            self.chart = chart

            self.cellViewList = [CellView]()
            self.divideViewList = [UIView]()
            var previousFrame = CGRect.zero
            for (i, e) in chart.timeSeriesList.enumerated() {
                let cellView = CellView()
                cellView.frame = Util.getLegendCellViewFrame(topViewFrame: previousFrame)
                cellView.drawCell(chart: chart, timeSeries: e)
                self.addSubview(cellView)
                previousFrame = cellView.frame
                if i != chart.timeSeriesList.count - 1 {
                    let divideView = UIView()
                    divideView.frame = Util.getLegendDivideViewFrame(topViewFrame: cellView.frame)
                    previousFrame = divideView.frame
                    self.addSubview(divideView)
                    self.divideViewList.append(divideView)
                }
                self.cellViewList.append(cellView)
            }

            self.bottomShadowView = UIView()
            self.addSubview(self.bottomShadowView)
            self.bottomShadowView.translatesAutoresizingMaskIntoConstraints = false
            self.bottomShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.bottomShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.bottomShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.bottomShadowView.heightAnchor.constraint(equalToConstant: Util.SHADOW_HEIGHT).isActive = true
        }

        func renderLegendView(chart: Chart) {
            for (i, e) in chart.timeSeriesList.enumerated() {
                self.cellViewList[i].renderCell(chart: chart, timeSeries: e)
            }
            for i in self.divideViewList {
                i.backgroundColor = Util.getLegendDivideViewBackgroundColor()
            }
            self.backgroundColor = Util.getViewBackground()
            self.bottomShadowView.backgroundColor = Util.getShadowViewBackground()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        class CellView : UIView {

            var chart: Chart!
            var timeSeries: TimeSeries!
            var timeSeriesLabel: UILabel!
            var rectangleColorLayer: RectangleColorLayer!
            var checkMarkLayer: CheckMarkLayer!
            var controlView: UIView!

            func drawCell(chart: Chart, timeSeries: TimeSeries) {
                self.chart = chart
                self.timeSeries = timeSeries

                // Label
                self.timeSeriesLabel = UILabel()
                self.timeSeriesLabel.text = self.timeSeries.name
                self.timeSeriesLabel.frame = Util.getLegendTimeSeriesLabelFrame()
                self.timeSeriesLabel.textAlignment = .left
                self.addSubview(self.timeSeriesLabel)

                // Rectangle Color
                self.rectangleColorLayer = RectangleColorLayer()
                self.layer.addSublayer(self.rectangleColorLayer)


                // Check mark
                self.checkMarkLayer = CheckMarkLayer()
                self.layer.addSublayer(self.checkMarkLayer)

                // Control
                self.controlView = UIView()
                self.controlView.frame = Util.getLegendControlViewFrame()
                self.addSubview(self.controlView)
            }

            func renderCell(chart: Chart, timeSeries: TimeSeries) {
                self.rectangleColorLayer.renderRectangleColor(chart: chart, timeSeries: timeSeries)
                self.checkMarkLayer.renderCheckMark(chart: chart, timeSeries: timeSeries)
                self.timeSeriesLabel.textColor = Util.getLegendTimeSeriesLabelColor()
            }

            override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                if let touch = touches.first {
                    self.timeSeries.hidden = !self.timeSeries.hidden
                    (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: self.chart)
                    (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: self.chart)
                    (Dispatcher.get(id: Dispatcher.LEGEND_VIEW) as! LegendView).renderLegendView(chart: self.chart)
                }
            }

            class RectangleColorLayer : CAShapeLayer {

                var chart: Chart!
                var timeSeries: TimeSeries!
                var rectangleColorPath: UIBezierPath!

                func renderRectangleColor(chart: Chart, timeSeries: TimeSeries) {
                    self.chart = chart
                    self.timeSeries = timeSeries
                    self.rectangleColorPath = UIBezierPath()

                    self.strokeColor = self.timeSeries.color.cgColor
                    self.fillColor = self.timeSeries.color.cgColor

                    let height = Util.getLegendCellViewFrame().size.height


                    if !timeSeries.hidden {
                        self.rectangleColorPath.append(UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: Util.PADDING, y: 0.5 * height - 0.5 * Util.LEGEND_COLOR_RECTANGLE_SIZE), size: CGSize(width: Util.LEGEND_COLOR_RECTANGLE_SIZE, height: Util.LEGEND_COLOR_RECTANGLE_SIZE)), cornerRadius: 2))
                    } else {
                        self.rectangleColorPath.append(UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: Util.PADDING + 0.5 * Util.LEGEND_COLOR_RECTANGLE_SIZE, y: 0.5 * height), size: CGSize(width: 0.0, height: 0.0)), cornerRadius: 2))
                    }

                    let pathAnimation = CABasicAnimation(keyPath: "path")
                    pathAnimation.duration = 0.2
                    pathAnimation.fromValue = self.presentation()?.path
                    pathAnimation.toValue = self.rectangleColorPath.cgPath
                    pathAnimation.fillMode = CAMediaTimingFillMode.forwards;
                    pathAnimation.isRemovedOnCompletion = false;
                    self.add(pathAnimation, forKey: pathAnimation.keyPath)


                    self.path = self.rectangleColorPath.cgPath
                }
            }

            class CheckMarkLayer : CAShapeLayer {

                var chart: Chart!
                var timeSeries: TimeSeries!
                var checkMarkPath: UIBezierPath!
                var curveStroke: Float!

                func renderCheckMark(chart: Chart, timeSeries: TimeSeries) {
                    self.chart = chart
                    self.timeSeries = timeSeries
                    self.checkMarkPath = UIBezierPath()

                    self.lineWidth = 2.0
                    self.strokeColor = Util.getLegendCheckMarkViewColor().cgColor

                    let height = Util.getLegendCellViewFrame().size.height
                    let width = Util.getLegendCellViewFrame().size.width

                    self.checkMarkPath.move(to: CGPoint(x: width - Util.PADDING - Util.LEGEND_CHECK_MARK_SIZE, y: height * 0.5 - Util.LEGEND_CHECK_MARK_SIZE * 0.5 + Util.LEGEND_CHECK_MARK_SIZE * 2 / 3))
                    self.checkMarkPath.addLine(to: CGPoint(x: width - Util.PADDING - Util.LEGEND_CHECK_MARK_SIZE + Util.LEGEND_CHECK_MARK_SIZE / 3, y: height * 0.5 + Util.LEGEND_CHECK_MARK_SIZE * 0.5))
                    self.checkMarkPath.move(to: CGPoint(x: width - Util.PADDING - Util.LEGEND_CHECK_MARK_SIZE + Util.LEGEND_CHECK_MARK_SIZE / 3, y: height * 0.5 + Util.LEGEND_CHECK_MARK_SIZE * 0.5))
                    self.checkMarkPath.addLine(to: CGPoint(x: width - Util.PADDING, y: height * 0.5 - Util.LEGEND_CHECK_MARK_SIZE * 0.5))

                    if timeSeries.hidden {
                        self.curveStroke = 0.0
                    } else {
                        self.curveStroke = 1.0
                    }

                    let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
                    strokeAnimation.duration = 0.2
                    strokeAnimation.fromValue = self.presentation()?.strokeEnd
                    strokeAnimation.toValue = self.curveStroke
                    strokeAnimation.fillMode = CAMediaTimingFillMode.forwards;
                    strokeAnimation.isRemovedOnCompletion = false;
                    self.add(strokeAnimation, forKey: strokeAnimation.keyPath)

                    self.path = self.checkMarkPath.cgPath
                }
            }
        }
    }

    class SwitchModeView : UIView {

        var chart: Chart!
        var switchModeLabel: UILabel!
        var topShadowView: UIView!
        var bottomShadowView: UIView!


        init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
            super.init(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height)))
        }

        func drawSwitchModeView(chart: Chart) {
            self.chart = chart

            self.switchModeLabel = UILabel()
            self.switchModeLabel.frame = self.bounds
            self.switchModeLabel.textAlignment = .center
            self.switchModeLabel.textColor = UIColor(red: 0.0 / 255.0, green: 117.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
            self.addSubview(self.switchModeLabel)


            self.topShadowView = UIView()
            self.addSubview(self.topShadowView)
            self.topShadowView.translatesAutoresizingMaskIntoConstraints = false
            self.topShadowView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.topShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.topShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.topShadowView.heightAnchor.constraint(equalToConstant: Util.SHADOW_HEIGHT).isActive = true

            self.bottomShadowView = UIView()
            self.addSubview(self.bottomShadowView)
            self.bottomShadowView.translatesAutoresizingMaskIntoConstraints = false
            self.bottomShadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.bottomShadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            self.bottomShadowView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.bottomShadowView.heightAnchor.constraint(equalToConstant: Util.SHADOW_HEIGHT).isActive = true
        }

        func renderSwitchModeView(chart: Chart) {
            self.chart = chart
            self.backgroundColor = Util.getViewBackground()
            self.topShadowView.backgroundColor = Util.getShadowViewBackground()
            self.bottomShadowView.backgroundColor = Util.getShadowViewBackground()
            self.switchModeLabel.text = Util.CURRENT_COLOR_MODE == Util.COLOR_MODE_DAY ? "Switch to Night Mode" : "Switch to Day Mode"
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                Util.CURRENT_COLOR_MODE = Util.CURRENT_COLOR_MODE == Util.COLOR_MODE_DAY ? Util.COLOR_MODE_NIGHT : Util.COLOR_MODE_DAY
                UserDefaults.standard.set(Util.CURRENT_COLOR_MODE, forKey: "colorMode")
                (Dispatcher.get(id: Dispatcher.TITLE_VIEW) as! TitleView).renderTitleView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.TITLE_LOWER_VIEW) as! TitleLowerView).renderTitleView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.SLIDE_VIEW) as! SlideView).renderSlideView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.CHART_VIEW) as! ChartView).renderChartView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.LEGEND_VIEW) as! LegendView).renderLegendView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.SWITCH_MODE_VIEW) as! SwitchModeView).renderSwitchModeView(chart: self.chart)
                (Dispatcher.get(id: Dispatcher.SELECT_CHART_VIEW) as! SelectChartView).renderSelectChartView()
                Dispatcher.get(id: Dispatcher.CONTAINER_VIEW).backgroundColor = Util.getContainerViewBackground()
            }
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    class TimeSeries {

        var id: String
        var name: String
        var color: UIColor
        var x: [Date]
        var y: [Float]
        var abscissa: [CGFloat]
        var ordinate: [CGFloat]
        var scale: CGFloat
        var hidden: Bool
        var width: CGFloat

        init(id: String, name: String, color: UIColor, x: [Date], y: [Float]) {
            self.id = id
            self.name = name
            self.color = color
            self.x = x
            self.y = y
            self.abscissa = [CGFloat]()
            self.ordinate = [CGFloat]()
            self.scale = 1.0
            self.hidden = false
            self.width = 0.0
        }
    }

    class Chart {

        var id: String
        var timeSeriesList: [TimeSeries]

        init(id: String, timeSeriesList: [TimeSeries]) {
            self.id = id
            self.timeSeriesList = timeSeriesList
        }
    }

    class Dispatcher {

        static let SLIDE_LEFT_FADE_VIEW = "SLIDE_LEFT_FADE_VIEW"
        static let SLIDE_RIGHT_FADE_VIEW = "SLIDE_RIGHT_FADE_VIEW"
        static let SLIDE_CONTROL_VIEW = "SLIDE_CONTROL_VIEW"
        static let SLIDE_SLIDER_VIEW = "SLIDE_SLIDER_VIEW"
        static let CHART_SCROLL_VIEW = "CHART_SCROLL_VIEW"
        static let CHART_MARKER_POPUP_VIEW = "CHART_MARKER_POPUP_VIEW"
        static let CHART_MARKER_LINE_VIEW = "CHART_MARKER_LINE_VIEW"
        static let SLIDE_VIEW = "SLIDE_VIEW"
        static let CHART_VIEW = "CHART_VIEW"
        static let LEGEND_VIEW = "LEGEND_VIEW"
        static let TITLE_VIEW = "TITLE_VIEW"
        static let TITLE_LOWER_VIEW = "TITLE_LOWER_VIEW"
        static let SWITCH_MODE_VIEW = "SWITCH_MODE_VIEW"
        static let CONTAINER_VIEW = "CONTAINER_VIEW"
        static let SELECT_CHART_VIEW = "SELECT_CHART_VIEW"
        static let SLIDE_LEFT_ARROW_VIEW = "SLIDE_LEFT_ARROW_VIEW"
        static let SLIDE_RIGHT_ARROW_VIEW = "SLIDE_RIGHT_ARROW_VIEW"

        static var viewController = [ViewController]()

        static func putController(viewController: ViewController) {
            self.viewController.append(viewController)
        }

        static func getController() -> ViewController {
            return self.viewController.first!
        }

        static var dictionary = [String : UIView]()

        static func get(id: String) -> UIView {
            return Dispatcher.dictionary[id]!
        }

        static func put(id: String, uiView: UIView) {
            Dispatcher.dictionary[id] = uiView
        }

        static func perform(action: () -> ()) {
            action()
        }
    }

    class Settings {

    }

    class Animator {

        static func animate(withDuration: TimeInterval, animations: @escaping () -> Void) {
            UIView.animate(withDuration: withDuration, delay: 0, animations: animations)
        }

        static func animate(withDuration: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
            UIView.animate(withDuration: withDuration, animations: animations, completion: completion)
        }
    }

    class Util {

        //
        static var ALL_CHARTS = [Chart]()

        static func load() {
            Util.getAllCharts()
            if let colorMode = UserDefaults.standard.string(forKey: "colorMode") {
                Util.CURRENT_COLOR_MODE = colorMode
            }
        }

        static func getAllCharts() -> [Chart] {
            if Util.ALL_CHARTS.count == 0 {
                Util.ALL_CHARTS = Util.loadJson(filename: "chart_data")
            }
            return Util.ALL_CHARTS
        }

        // Current State
        static var CURRENT_COLOR_MODE = COLOR_MODE_DAY
        static var CURRENT_CHART: Chart? = nil

        static func getCurrentChart() -> Chart {
            if(Util.CURRENT_CHART == nil) {
                Util.CURRENT_CHART = Util.getAllCharts().first!
            }
            return Util.CURRENT_CHART!
        }

        // Constants
        static let COLOR_MODE_DAY = "MODE_DAY"
        static let COLOR_MODE_NIGHT = "MODE_NIGHT"


        // Padding
        static let PADDING = CGFloat(15.0)

        static let SHADOW_HEIGHT = CGFloat(1.0)

        // Common Background
        static func getViewBackground() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 254.0 / 255.0, green: 254.0 / 255.0, blue: 254.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 31.0 / 255.0, green: 46.0 / 255.0, blue: 65.0 / 255.0, alpha: 1.0)
            }
        }

        static func getShadowViewBackground() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 200.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 17.0 / 255.0, green: 25.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
            }
        }



        // Container View
        static func getContainerViewBackground() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 239.0 / 255.0, green: 238.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 22.0 / 255.0, green: 33.0 / 255.0, blue: 46.0 / 255.0, alpha: 1.0)
            }
        }


        // Title View
        static func getTitleViewFrame() -> CGRect {
            return CGRect(origin: CGPoint.zero, size: CGSize(width: Util.getBoundsWidth(), height: Util.getBoundsHeight() * 0.16 * 0.55))
        }

        static func getTitleTopViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getTitleViewFrame().size.width, height: Util.getTitleViewFrame().size.height))
        }

        static func getTitleStatisticsLabelFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: Util.getTitleTopViewFrame().size.height * 0.4), size: CGSize(width: Util.getTitleTopViewFrame().size.width, height: Util.getTitleTopViewFrame().size.height * 0.6))
        }



        static func getTitleTopViewBackgroundColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 247.0 / 255.0, green: 247.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 30.0 / 255.0, green: 47.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
            }
        }

        static func getTitleStatisticsLabelColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
            }
        }

        static func getTitleChartNameLabelColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 109.0 / 255.0, green: 109.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 89.0 / 255.0, green: 106.0 / 255.0, blue: 129.0 / 255.0, alpha: 1.0)
            }
        }

        //

        static func getTitleLowerViewFrame() -> CGRect {
            return CGRect(origin: CGPoint.zero, size: CGSize(width: Util.getBoundsWidth(), height: Util.getBoundsHeight() * 0.16 * 0.45))
        }

        static func getTitleChartNameLabelFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.PADDING, y: Util.getTitleLowerViewFrame().size.height * 0.4), size: CGSize(width: Util.getTitleViewFrame().size.width, height: Util.getTitleViewFrame().size.height * 0.5))
        }

        static func getTitleChangeChartFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getTitleViewFrame().size.width * 0.8, y: Util.getTitleChartNameLabelFrame().origin.y), size: CGSize(width: Util.getTitleViewFrame().size.width * 0.2, height: Util.getTitleChartNameLabelFrame().size.height))
        }

        static func getContainerViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getTitleViewFrame().origin.x, y: Util.getTitleViewFrame().maxY), size: CGSize(width: Util.getTitleViewFrame().size.width, height: Util.getBoundsHeight() - Util.getTitleViewFrame().maxY))
        }

        // Select chart view

        static func getSelectChartViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getBoundsWidth(), height: Util.getBoundsHeight()))
        }




        // Chart View

        static let CHART_AXIS_HEIGHT_SHARE = CGFloat(0.08)
        static let CHART_MARKER_ROW_HEIGHT_SHARE = CGFloat(0.06)
        static let CHART_MARKER_WIDTH_SHARE = CGFloat(0.3)

        static func getChartViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: getTitleLowerViewFrame().height), size: CGSize(width: getTitleLowerViewFrame().size.width, height: Util.getBoundsHeight() * 0.45))
        }

        static func getChartScrollViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.PADDING, y: Util.PADDING), size: CGSize(width: Util.getChartViewFrame().size.width - 2 * Util.PADDING, height: Util.getChartViewFrame().size.height - Util.PADDING))
        }

        static func getChartAxisViewFrame(contentSize: CGFloat = 0) -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: Util.getChartScrollViewFrame().size.height * (1.0 - Util.CHART_AXIS_HEIGHT_SHARE)), size: CGSize(width: contentSize, height: Util.getChartScrollViewFrame().size.height * Util.CHART_AXIS_HEIGHT_SHARE))
        }

        static func getChartAxisLineViewFrame(contentSize: CGFloat = 0) -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getChartAxisViewFrame(contentSize: contentSize).size.width, height: 0.5))
        }

        static func getChartAxisLabelContainerViewFrame(contentSize: CGFloat = 0) -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getChartAxisViewFrame(contentSize: contentSize).size.width, height: Util.getChartAxisViewFrame(contentSize: contentSize).size.height * 0.85))
        }

        static func getChartGridViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getChartScrollViewFrame().origin.x, y: Util.getChartScrollViewFrame().origin.y), size: CGSize(width: Util.getChartScrollViewFrame().size.width, height: Util.getChartAxisViewFrame().origin.y))
        }

        static func getChartMarkerPopupViewFrame(count: Int = 2) -> CGRect {
            return CGRect(origin: CGPoint(x: 100.0, y: Util.PADDING / 3), size: CGSize(width: Util.getChartViewFrame().size.width * Util.CHART_MARKER_WIDTH_SHARE, height: Util.getChartViewFrame().size.width * Util.CHART_MARKER_ROW_HEIGHT_SHARE * CGFloat(max(2, count))))
        }

        static func getChartMarkerDayMonthLabelFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getChartMarkerPopupViewFrame().size.width * 0.05, y: 0.0), size: CGSize(width: Util.getChartMarkerPopupViewFrame().size.width * 0.5, height: Util.getChartMarkerPopupViewFrame().size.height * 0.5))
        }

        static func getChartMarkerYearLabelFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getChartMarkerDayMonthLabelFrame().origin.x, y: Util.getChartMarkerDayMonthLabelFrame().origin.y + Util.getChartMarkerDayMonthLabelFrame().size.height), size: CGSize(width: Util.getChartMarkerDayMonthLabelFrame().size.width, height: Util.getChartMarkerDayMonthLabelFrame().size.height))
        }

        static func getChartMarkerRowViewFrame(topViewFrame: CGRect = CGRect.zero) -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getChartMarkerDayMonthLabelFrame().origin.x + Util.getChartMarkerDayMonthLabelFrame().size.width, y: topViewFrame.origin.y + topViewFrame.size.height), size: CGSize(width: Util.getChartMarkerPopupViewFrame().size.width - Util.getChartMarkerDayMonthLabelFrame().origin.x - Util.getChartMarkerDayMonthLabelFrame().size.width, height: Util.getChartMarkerDayMonthLabelFrame().size.height))
        }

        static func getChartAxisLabelColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 151.0 / 255.0, green: 158.0 / 255.0, blue: 164.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 90.0 / 255.0, green: 108.0 / 255.0, blue: 128.0 / 255.0, alpha: 1.0)
            }
        }

        static func getChartAxisLineColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 225.0 / 255.0, green: 226.0 / 255.0, blue: 227.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 18.0 / 255.0, green: 27.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
            }
        }

        static func getChartGridColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 243.0 / 255.0, green: 243.0 / 255.0, blue: 243.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 25.0 / 255.0, green: 38.0 / 255.0, blue: 53.0 / 255.0, alpha: 1.0)
            }
        }

        static func getChartMarkerPopupViewBackgroundColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 244.0 / 255.0, green: 244.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 24.0 / 255.0, green: 39.0 / 255.0, blue: 56.0 / 255.0, alpha: 1.0)
            }
        }

        static func getChartMarkerPopupLabelColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
            }
        }

        // Slide View

        static let SLIDE_VIEW_PADDING = CGFloat(2)
        static let SLIDE_ARROW_SIZE = CGFloat(10.0)
        static let SLIDE_WINDOW_MIN_SIZE = CGFloat(30.0)

        static func getSlideViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: Util.getChartViewFrame().origin.y + Util.getChartViewFrame().size.height), size: CGSize(width: Util.getChartViewFrame().size.width, height: Util.getBoundsHeight() * 0.07))
        }

        static func getSlideControlViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.PADDING, y: 0.0), size: CGSize(width: Util.getSlideViewFrame().size.width - Util.PADDING * 2.0, height: Util.getSlideViewFrame().size.height))
        }

        static func getSlideLeftFadeViewFrame(sliderViewFrame: CGRect = Util.getSlideSliderViewFrame()) -> CGRect {
            return CGRect(origin: CGPoint(x: Util.PADDING, y: Util.SLIDE_VIEW_PADDING), size: CGSize(width: sliderViewFrame.origin.x - Util.PADDING, height: Util.getSlideViewFrame().size.height - 2 * Util.SLIDE_VIEW_PADDING))
        }

        static func getSlideRightFadeViewFrame(sliderViewFrame: CGRect = Util.getSlideSliderViewFrame()) -> CGRect {
            return CGRect(origin: CGPoint(x: sliderViewFrame.origin.x + sliderViewFrame.size.width, y: Util.SLIDE_VIEW_PADDING), size: CGSize(width: Util.getSlideControlViewFrame().size.width - sliderViewFrame.origin.x - sliderViewFrame.size.width + Util.PADDING, height: Util.getSlideViewFrame().size.height - 2 * Util.SLIDE_VIEW_PADDING))
        }

        static func getSlideSliderViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.PADDING, y: 0.0), size: CGSize(width: getSlideControlViewFrame().size.width, height: Util.getSlideViewFrame().size.height))
        }

        static func getSlideCenterWindowViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.getSlideSliderViewFrame().size.width * 0.15, y: 0.0), size: CGSize(width: Util.getSlideSliderViewFrame().size.width * 0.7, height: Util.getSlideSliderViewFrame().size.height))
        }

        static func getSlideLeftArrowViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: CGFloat(15.0), height: Util.getSlideSliderViewFrame().size.height))
//            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getSlideCenterWindowViewFrame().origin.x, height: Util.getSlideSliderViewFrame().size.height))
        }

        static func getSlideRightArrowViewFrame() -> CGRect {
            return Util.getSlideLeftArrowViewFrame()
//            return CGRect(origin: CGPoint(x: Util.getSlideCenterWindowViewFrame().origin.x + Util.getSlideCenterWindowViewFrame().size.width, y: 0.0), size: CGSize(width: Util.getSlideSliderViewFrame().size.width - Util.getSlideCenterWindowViewFrame().origin.x - Util.getSlideCenterWindowViewFrame().size.width, height: Util.getSlideSliderViewFrame().size.height))
        }

        static func getSlideSliderColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 200.0 / 255.0, green: 212.0 / 255.0, blue: 223.0 / 255.0, alpha: 0.8)
            } else {
                return UIColor.white.withAlphaComponent(0.1)
            }
        }

        static func getSlideArrowViewColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
            }
        }

        // Legend View

        static let LEGEND_CELL_HEIGHT_SHARE = CGFloat(0.07)
        static let LEGEND_LEFT_PADDING = CGFloat(Util.PADDING * 3)
        static let LEGEND_COLOR_RECTANGLE_SIZE = CGFloat(12.0)
        static let LEGEND_CHECK_MARK_SIZE = Util.LEGEND_COLOR_RECTANGLE_SIZE

        static func getLegendViewFrame(count: Int = 0) -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: Util.getSlideViewFrame().origin.y + Util.getSlideViewFrame().size.height), size: CGSize(width: Util.getSlideViewFrame().size.width, height: Util.getBoundsHeight() * Util.LEGEND_CELL_HEIGHT_SHARE * CGFloat(count) + CGFloat(max(0, count - 1))))
        }

        static func getLegendDivideViewFrame(topViewFrame: CGRect = CGRect.zero) -> CGRect {
            return CGRect(origin: CGPoint(x: Util.LEGEND_LEFT_PADDING, y: topViewFrame.origin.y + topViewFrame.size.height), size: CGSize(width: Util.getLegendViewFrame().size.width - Util.LEGEND_LEFT_PADDING, height: 0.5))
        }

        static func getLegendCellViewFrame(topViewFrame: CGRect = CGRect.zero) -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: topViewFrame.origin.y + topViewFrame.size.height), size: CGSize(width: Util.getLegendViewFrame().size.width, height: Util.getBoundsHeight() * Util.LEGEND_CELL_HEIGHT_SHARE))
        }

        static func getLegendControlViewFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: Util.getLegendCellViewFrame().size.width, height: Util.getLegendCellViewFrame().size.height))
        }

        static func getLegendTimeSeriesLabelFrame() -> CGRect {
            return CGRect(origin: CGPoint(x: Util.LEGEND_LEFT_PADDING, y: 0), size: CGSize(width: Util.getLegendCellViewFrame().size.width, height: Util.getLegendCellViewFrame().size.height))
        }

        static func getLegendTimeSeriesLabelColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
            }
        }

        static func getLegendCheckMarkViewColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 0.0 / 255.0, green: 117.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 0.0 / 255.0, green: 117.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
            }
        }

        static func getLegendDivideViewBackgroundColor() -> UIColor {
            if Util.CURRENT_COLOR_MODE == COLOR_MODE_DAY {
                return UIColor(red: 200.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
            } else {
                return UIColor(red: 17.0 / 255.0, green: 26.0 / 255.0, blue: 36.0 / 255.0, alpha: 1.0)
            }
        }

        // Switch Mode View

        static let SWITCH_MODE_TOP_MARGIN = CGFloat(20.0)

        static func getSwitchModeViewFrame(count: Int = 0) -> CGRect {
            return CGRect(origin: CGPoint(x: 0, y: Util.getLegendViewFrame(count: count).origin.y + Util.getLegendViewFrame(count: count).size.height + Util.SWITCH_MODE_TOP_MARGIN), size: CGSize(width: Util.getLegendViewFrame(count: count).size.width, height: Util.getBoundsHeight() * 0.06))
        }



        static var SIZE = UIScreen.main.bounds.size

        static func getBoundsHeight() -> CGFloat {
            return Util.SIZE.height
        }

        static func getBoundsWidth() -> CGFloat {
            return Util.SIZE.width
        }

        static func loadJson(filename fileName: String) -> [Chart] {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let json = try JSONSerialization.jsonObject(with: data) as? [AnyObject]
                    var chartsList = [Chart]()
                    for (i, e) in json!.enumerated() {
                        var timeSeriesList = [TimeSeries]()
                        let jsonObject = e as AnyObject
                        let jsonNames = jsonObject["names"] as? [String : String]
                        for jsonName in jsonNames! {
                            let id = jsonName.key
                            let name = jsonName.value
                            var color = UIColor.white
                            var x = [Date]()
                            var y = [Float]()
                            let jsonColors = jsonObject["colors"] as? [String : String]
                            for jsonColor in jsonColors! {
                                if id == jsonColor.key {
                                    let red = (Int(jsonColor.value.dropFirst(), radix: 16)! >> 16) & 0xff
                                    let green = (Int(jsonColor.value.dropFirst(), radix: 16)! >> 8) & 0xff
                                    let blue = (Int(jsonColor.value.dropFirst(), radix: 16)! >> 0) & 0xff
                                    color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
                                    break
                                }
                            }
                            let jsonColumns = jsonObject["columns"] as? [[AnyObject]]
                            for jsonColumn in jsonColumns! {
                                if "x" == jsonColumn.first as? String {
                                    for point in jsonColumn.dropFirst() {
                                        x.append(Date(timeIntervalSince1970: (point as! Double) / 1000))
                                    }
                                } else if id == jsonColumn.first as? String {
                                    for point in jsonColumn.dropFirst() {
                                        y.append(point as! Float)
                                    }
                                }
                            }
                            timeSeriesList.append(TimeSeries(id: id, name: name, color: color, x: x, y: y))
                        }
                        chartsList.append(Chart(id: String(i), timeSeriesList: timeSeriesList.sorted(by: { $0.id < $1.id })))
                    }
                    return chartsList
                } catch {
                    print("Error! Unable to parse  \(fileName).json")
                }
            }
            return []
        }

    }

}
