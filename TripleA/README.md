# 石头剪刀布

## 引脚分配

- Clk 时钟信号 -> PIN65
- Rst 重置信号 -> U7-Key2
- 人机对战开关 -> U7-Key1
- 玩家输入（红色石头，黄色剪刀，绿色布）
  - Player 1（左边交通灯）
    - 石头 -> PIN15 -> U2-KEY1
    - 剪刀 -> PIN11 -> U2-KEY2
    - 布 -> PIN10 -> U2-KEY3
  - Player 2（右边交通灯）
    - 石头 -> PIN58 -> U3-KEY1
    - 剪刀 -> PIN59 -> U3-KEY2
    - 布 -> PIN60 -> U3-KEY3
- 玩家输出（显示玩家选了啥）
  - Player 1
    - 石头 -> PIN45 -> LL1
    - 剪刀 -> PIN43 -> LL2
    - 布 -> PIN41 -> LL3
  - Player 2
    - 石头 -> PIN46 -> LL7
    - 剪刀 -> PIN44 -> LL8
    - 布 -> PIN42 -> LL9
- 结果输出（谁赢，靠近谁就是谁赢）
  - Player 1 Wins -> PIN71 -> LL12
  - Game Draw -> PIN70 -> LL11
  - Player 2 Wins -> PIN69 -> LL10