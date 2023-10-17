//
//  ViewCoordinator.swift
//  Example
//
//  Created by MAHESHWARAN on 13/08/23.
//

import SwiftUI

extension ContentView {
  
  enum ViewCoordinator: String, CaseIterable {
    case text, textFieldView, textEditorView, imageView, pickerView, stackView, colorView, gradientView,
         buttonView, stepperView, datePickerView, photoPickerView, videoPicker, moveItemView, listView, scrollReaderView,
         scrollView, matchedGeometryEffectView, alertView, animationView, blurView, dialogAlertView, searchView,
         tabView, safeAreaView, loaderView, colorPickerView, toolBarView, toggleView, segmentedControlView, timer,
         link, form, swipe, refresh, overlay, disclosureView, groupBox, gesture, progess, asyncImageView,
         viewHeight, sheetView, bottomSheet, customLayout, popOver, quickLook, menu, propertyWrapper, notification,
         toast, overlaySheet, navigation, transition, dragGesture, observedObjectView, binding
    
    var title: String {
      switch self {
      case .text: return "Text"
      case .textFieldView: return "Text Field"
      case .textEditorView: return "Text Editor"
      case .imageView: return "Image"
      case .pickerView: return "Picker"
      case .stackView: return "Stack"
      case .colorView: return "Color"
      case .gradientView: return "Gradient"
      case .buttonView: return "Button"
      case .stepperView: return "Stepper"
      case .datePickerView: return "Date Picker"
      case .photoPickerView: return "Photo Picker"
      case .videoPicker: return "Video Picker"
      case .moveItemView: return "Move Item"
      case .listView: return "List"
      case .scrollReaderView: return "Scroll Reader"
      case .scrollView: return "Scroll"
      case .matchedGeometryEffectView: return "Matched Geometry Effect"
      case .alertView: return "Alert"
      case .animationView: return "Animation"
      case .blurView: return "Blur"
      case .dialogAlertView: return "Dialog Alert"
      case .searchView: return "Search"
      case .tabView: return "Tab"
      case .safeAreaView: return "SafeArea"
      case .loaderView: return "Loader"
      case .colorPickerView: return "Color Picker"
      case .toolBarView: return "ToolBar"
      case .toggleView: return "Toggle"
      case .segmentedControlView: return "Segmented Control"
      case .timer: return "Timer"
      case .link: return "Link"
      case .form: return "Form"
      case .swipe: return "Swipe"
      case .refresh: return "Refresh"
      case .overlay: return "Overlay"
      case .disclosureView: return "Disclosure"
      case .groupBox: return "GroupBox"
      case .gesture: return "Gesture"
      case .progess: return "Progress"
      case .asyncImageView: return "Async Image"
      case .viewHeight: return "View Height"
      case .sheetView: return "Sheet"
      case .bottomSheet: return "Bottom Sheet"
      case .customLayout: return "Layout"
      case .popOver: return "PopOver"
      case .quickLook: return "Quick Look"
      case .menu: return "Menu"
      case .propertyWrapper: return "Poperty Wrapper"
      case .notification: return "Notification"
      case .toast: return "Toast"
      case .overlaySheet: return "Sheet"
      case .navigation: return "Navigation"
      case .transition: return "Transition"
      case .dragGesture: return "Drag Gesture"
      case .observedObjectView: return "Observed Object"
      case .binding: return "Binding"
      }
    }
    
    
    @ViewBuilder
    var destinationView: some View {
      switch self {
      case .text: CustomTextView()
      case .textFieldView: CustomTextFieldView()
      case .textEditorView: CustomTextEditorView()
      case .imageView: CustomImageView()
      case .pickerView: CustomPickerView()
      case .stackView: CustomStackView()
      case .colorView: CustomColorView()
      case .gradientView: CustomGradientView()
      case .buttonView: CustomButtonView()
      case .stepperView: CustomStepperView()
      case .datePickerView: CustomDatePickerView()
      case .photoPickerView: CustomPhotoPickerView()
      case .videoPicker: CustomVideoPhotoPickerView()
      case .moveItemView: CustomMoveItemView()
      case .listView: CustomListView()
      case .scrollReaderView: CustomScrollReaderView()
      case .scrollView: CustomScrollView()
      case .matchedGeometryEffectView: CustomMatchedGeometryEffectView()
      case .alertView: CustomAlertView()
      case .animationView: CustomAnimationView()
      case .blurView: CustomBlurView()
      case .dialogAlertView: CustomDialogAlertView()
      case .searchView: CustomSearchView()
      case .tabView: CustomTabView()
      case .safeAreaView: CustomSafeAreaView()
      case .loaderView: CustomLoaderView()
      case .colorPickerView: CustomColorPickerView()
      case .toolBarView: CustomToolBarButtonView()
      case .toggleView: CustomToggleView()
      case .segmentedControlView: CustomSegmentedControlView()
      case .timer: CustomTimerView()
      case .link: CustomLinkView()
      case .form: CustomFormView()
      case .swipe: CustomSwipeActionView()
      case .refresh: CustomRefreshView()
      case .overlay: CustomOverlayView()
      case .disclosureView: CustomDisclosureGroupView()
      case .groupBox: CustomGroupBoxView()
      case .gesture: CustomGestureView()
      case .progess: CustomProgressView()
      case .asyncImageView: CustomAsyncImageView()
      case .viewHeight: CustomViewHeight()
      case .sheetView: CustomSheetView()
      case .bottomSheet: CustomBottomView()
      case .customLayout: CustomLayoutView()
      case .popOver: CustomPopOverView()
      case .quickLook: CustomQuickLookView()
      case .menu: CustomMenuView()
      case .propertyWrapper: CustomPropertyWrapper()
      case .notification: CustomNotificationObserverView()
      case .toast: CustomToastView()
      case .overlaySheet: CustomOverlaySheetView()
      case .navigation: CustomNavigationView()
      case .transition: CustomTransitionView()
      case .dragGesture: CustomDragGestureView()
      case .observedObjectView: CustomObservedObjectView()
      case .binding: CustomBindingView()
      }
    }
  }
}
