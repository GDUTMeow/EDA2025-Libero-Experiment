# 交通灯设计

按教材7.7.3 交通灯控制器（p260）进行设计，烧录并测试。


## 引脚定义

- Clk 时钟信号 (1kHz) -> PIN 23
- en 使能端（高位使能） -> PIN 11 -> U2-KEY2
- Rst 重置端（高位重置） -> PIN 15 -> U2-KEY1
- 交通灯 1（NS 方向）
  - 红灯 -> PIN 2 -> LL1/LED1
  - 黄灯 -> PIN 3 -> LL2/LED2
  - 绿灯 -> PIN 4 -> LL3/LED3
- 交通灯 2（EW 方向）
  - 红灯 -> PIN 46 -> LL4/LED4
  - 黄灯 -> PIN 45 -> LL5/LED5
  - 绿灯 -> PIN 44 -> LL6/LED6

> [!important]
> 
> 注：LED 用于辅助判断，实验的时候需要把三个灯对应的 PIN 给接到对应的 LL 去
