# WaterOpenDemo
💧转场动画

在dismiss动画时遇到了黑色背景的情况，查看视图层级发现是window的颜色。原因是普通的present后，查看xcode视图层级，vc的层级发生改变，只显示当前present出来的vc。
如果需要都显示 此处的处理方法是设置了self.modalPresentationStyle = UIModalPresentationCustom;
当设置为custom时，查看视图层级，两个vc同时存在，这样就可以实现当dismiss动画时，也能显示目标视图。
