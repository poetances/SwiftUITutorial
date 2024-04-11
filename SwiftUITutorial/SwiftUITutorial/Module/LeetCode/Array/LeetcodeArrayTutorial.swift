//
//  LeecodeArrayTutorial.swift
//  SwiftUITutorial
//
//  Created by zcj on 2024/3/28.
//

import SwiftUI

struct LeetcodeArrayTutorial: View {

    var body: some View {
        ScrollView {
            LazyVStack {

            }
        }
    }
}

extension LeetcodeArrayTutorial {

    
    /// 二分查找
    /// 给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1
    func search(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty { return -1 }
        if target < nums[0] || target > nums[nums.count - 1] {
            return -1
        }
        var left = 0, right = nums.count - 1
        while left <= right {
            let mid = left + ((right - left) >> 1)
            if target == nums[mid] {
                return mid
            } else if target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return -1
    }

    /**
     移除元素
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并原地修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。

     示例 1: 给定 nums = [3,2,2,3], val = 3, 函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。 你不需要考虑数组中超出新长度后面的元素。

     示例 2: 给定 nums = [0,1,2,2,3,0,4,2], val = 2, 函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。
     */
    func remove(_ nums: inout [Int], _ val: Int) -> Int {
        var sloveIndex = 0
        for fastIndex in 0 ..< nums.count {
            if val != nums[fastIndex] {
                nums[sloveIndex] = nums[fastIndex]
                sloveIndex += 1
            }
        }
        return sloveIndex
    }

    /**
     有序数组的平方

     给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。

     示例 1：

     输入：nums = [-4,-1,0,3,10]
     输出：[0,1,9,16,100]
     解释：平方后，数组变为 [16,1,0,9,100]，排序后，数组变为 [0,1,9,16,100]
     示例 2：

     输入：nums = [-7,-3,2,3,11]
     输出：[4,9,9,49,121]
     */
    func sortSquares(_ nums: [Int]) -> [Int] {
        var start = 0, end = nums.count - 1
        var index = nums.count - 1
        var result = [Int]()
        for _ in 0 ..< nums.count {
            if nums[start]*nums[start] < nums[end]*nums[end] {
                result[index] = nums[end]*nums[end]
                end -= 1
            } else {
                result[index] = nums[start]*nums[end]
                start += 1
            }
            index -= 1
        }
        return result
    }

    /**
     长度最小的子数组
     给定一个含有 n 个正整数的数组和一个正整数 s ，找出该数组中满足其和 ≥ s 的长度最小的 连续 子数组，并返回其长度。如果不存在符合条件的子数组，返回 0。

     示例：

     输入：s = 7, nums = [2,3,1,2,4,3]
     输出：2
     解释：子数组 [4,3] 是该条件下的长度最小的子数组。
     提示：

     1 <= target <= 10^9
     1 <= nums.length <= 10^5
     1 <= nums[i] <= 10^5

     ``` 暴力算法，时间复杂度O(n^2)
     class Solution {
     public:
         int minSubArrayLen(int s, vector<int>& nums) {
             int result = INT32_MAX; // 最终的结果
             int sum = 0; // 子序列的数值之和
             int subLength = 0; // 子序列的长度
             for (int i = 0; i < nums.size(); i++) { // 设置子序列起点为i
                 sum = 0;
                 for (int j = i; j < nums.size(); j++) { // 设置子序列终止位置为j
                     sum += nums[j];
                     if (sum >= s) { // 一旦发现子序列和超过了s，更新result
                         subLength = j - i + 1; // 取子序列的长度
                         result = result < subLength ? result : subLength;
                         break; // 因为我们是找符合条件最短的子序列，所以一旦符合条件就break
                     }
                 }
             }
             // 如果result没有被赋值的话，就返回0，说明没有符合条件的子序列
             return result == INT32_MAX ? 0 : result;
         }
     };
     ```
     */
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var result = Int.max
        var sum = 0
        var starIndex = 0
        for endIndex in 0..<nums.count {
            sum += nums[endIndex]

            while sum >= target {
                result = min(result, endIndex - starIndex + 1)
                sum -= nums[starIndex]
                starIndex += 1
            }
        }

        return result == Int.max ? 0 : result
    }

    /**
     螺旋矩阵II

     给定一个正整数 n，生成一个包含 1 到 n^2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。

     示例:
     输入: 3 输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]
     https://github.com/youngyangyang04/leetcode-master/blob/master/problems/0059.%E8%9E%BA%E6%97%8B%E7%9F%A9%E9%98%B5II.md
     */
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

        var startRow = 0
        var startColumn = 0
        var loopCount = n / 2
        let mid = n / 2
        var count = 1
        var offset = 1
        var row: Int
        var column: Int

        while loopCount > 0 {
            row = startRow
            column = startColumn

            for c in column ..< startColumn + n - offset {
                result[startRow][c] = count
                count += 1
                column += 1
            }

            for r in row ..< startRow + n - offset {
                result[r][column] = count
                count += 1
                row += 1
            }

            for _ in startColumn ..< column {
                result[row][column] = count
                count += 1
                column -= 1
            }

            for _ in startRow ..< row {
                result[row][column] = count
                count += 1
                row -= 1
            }

            startRow += 1
            startColumn += 1
            offset += 2
            loopCount -= 1
        }

        if (n % 2) != 0 {
            result[mid][mid] = count
        }
        return result
    }
}

#Preview {
    LeetcodeArrayTutorial()
}
