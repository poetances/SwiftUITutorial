//
//  AddingAnimationActionTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/2/22.
//

import SwiftUI

/*
 在 SwiftUI 中，实现一个动画需要以下三个要素：

 一个时序曲线算法函数
 将状态（特定依赖项）同该时序曲线函数相关联的声明
 一个依赖于该状态（特定依赖项）的可动画部件

 时序算法函数有Animation提供
 Animation时序函数很多，而且提供了时间控制

 Transaction用于更加精准的控制动画。无论是修饰符 animation 还是全局函数 withAnimation ，实际上都是在视图中声明 Transaction 的快捷方法，内部分别对应着 transaction 和 withTransaction。
 */
struct AddingAnimationActionTutorial: View {

    @State private var translateAnimation = false
    @State private var opacityAnimation = false
    @State private var scaleAnimation = false

    @State private var trigger = true
    // MARK: - system
    var body: some View {
        VStack(spacing: 15) {
            with_animation
            with_animation_completion
            animation_state
            phase_animator
            keyframe_animator
        }
    }
}

// MARK: - withAnimation(_:_:)
extension AddingAnimationActionTutorial {
    /*
     withAnimation需要传Animation
     */
    var with_animation: some View {
        VStack {
            Text("WithAnimation")
                .offset(x: translateAnimation ? 50:0)
            Button("EaseInOut") {
                withAnimation(.easeInOut(duration: 1)) {
                    translateAnimation.toggle()
                }
            }
            Button("Bouncy") {
                withAnimation(.bouncy) {
                    translateAnimation.toggle()
                }
            }
            Button("Smooth") {
                withAnimation(.smooth) {
                    translateAnimation.toggle()
                }
            }
            Button("Snappy") {
                withAnimation(.snappy) {
                    translateAnimation.toggle()
                }
            }
        }
    }

    /*
     AnimationCompletionCriteria官方没有很好的解释，网上也没有很好的资料，一般不使用即可
     */
    var with_animation_completion: some View {
        VStack {
            Text("Animation")
                .opacity(opacityAnimation ? 0 : 1)
                .scaleEffect(scaleAnimation ? 3 : 1)
            Button("Snappy") {
                withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                    scaleAnimation.toggle()
                } completion: {
                    print("动画完成")
                }

            }
        }
    }
}

// MARK: - animation(_:)
extension AddingAnimationActionTutorial {

    /*
     通过animation(_:)来进行动画修饰
     */
    var animation_state: some View {
        VStack {
            Text("Animation")
                .offset(x: translateAnimation ? 50:0)
                .scaleEffect(scaleAnimation ? 2:1)
                .opacity(opacityAnimation ? 0.2:1)
                .animation(.easeIn, value: translateAnimation)
                .animation(.bouncy, value: scaleAnimation)
                .animation(.spring, value: opacityAnimation)

            Button("Animation") {
                translateAnimation.toggle()
                scaleAnimation.toggle()
                opacityAnimation.toggle()
            }

        }
    }
}

// MARK: - PhaseAnimator
extension AddingAnimationActionTutorial {

    var phase_animator: some View {
        HStack(spacing: 15) {
            PhaseAnimator([true, false]) { phase in
                RoundedRectangle(cornerRadius: phase ? 10 : 30)
                    .fill(.green)
                    .frame(width: 50, height: 50)
                    .overlay{ Text(phase ? "true" : "false") }
            }
            
            PhaseAnimator([10, 20, 30, 40]) { phase in
                RoundedRectangle(cornerRadius: phase)
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay { Text("\(Int(phase))") }
            }

            PhaseAnimator([10, 20, 30, 40], trigger: trigger) { phase in
                RoundedRectangle(cornerRadius: phase)
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay { Text("\(Int(phase))") }
            }
            Button("Trigger") {
                trigger.toggle()
            }

            // 默认每个阶段动画都是spring
            PhaseAnimator([10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]) { phase in
                RoundedRectangle(cornerRadius: phase)
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay { Text("\(Int(phase))") }
            } animation: { phase in
                return Animation.easeInOut(duration: 5/phase)
            }
        }
    }
}

// MARK: - KeyframeAniamtor
extension AddingAnimationActionTutorial {

    var keyframe_animator: some View {
        HStack(spacing: 15) {
            Circle()
                .foregroundColor(.red)
                .frame(width: 50)
                .keyframeAnimator(initialValue: CircleValues()) { content, value in
                    content
                        .scaleEffect(value.scale)
                        .offset(y: -value.offset)
                } keyframes: { _ in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(1.2, duration: 0.2)
                        CubicKeyframe(1.2, duration: 0.3)
                        CubicKeyframe(1, duration: 0.2)
                    }
                    KeyframeTrack(\.offset) {
                        SpringKeyframe(0, duration: 0.2, spring: .bouncy)
                        SpringKeyframe(100, duration: 0.3, spring: .bouncy)
                        SpringKeyframe(0, duration: 0.2, spring: .bouncy)
                    }
                }
        }
    }

    struct CircleValues {
        var scale = 1.0
        var offset = 0.0
    }
}

#Preview {
    AddingAnimationActionTutorial()
}
