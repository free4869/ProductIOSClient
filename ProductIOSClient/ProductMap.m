//
//  ProductMap.m
//  ProductIOSClient
//
//  Created by Shao Wei on 7/19/13.
//  Copyright (c) 2013 Shao Wei. All rights reserved.
//

#import "ProductMap.h"

static NSDictionary *myProductMap;
@implementation ProductMap

@synthesize myProductMap = _myProductMap;

+ (void)init
{
    myProductMap = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"ic_product_lianyu.JPG", @"鲢鱼", 
                    @"ic_product_lianyu.JPG", @"江鲢鱼",
                    @"ic_product_heiyu.JPG", @"黑鱼",
                    @"ic_product_hongzunyu.JPG", @"红鳟鱼",
                    @"ic_product_luyu.JPG", @"鲈鱼",
                    @"ic_product_luofeiyu.JPG", @"罗非鱼",
                    @"ic_product_bianyu.JPG", @"鳊鱼",
                    @"ic_product_caoyu.JPG", @"草鱼",
                    @"ic_product_huocaoyu.JPG", @"活草鱼",
                    @"ic_product_guiyu.JPG", @"桂鱼",
                    @"ic_product_guiyu.JPG", @"活桂鱼",
                    @"ic_product_jiyu.JPG", @"鲫鱼",
                    @"ic_product_jiyu.JPG", @"活鲫鱼",
                    @"ic_product_liyu.JPG", @"鲤鱼",
                    @"ic_product_liyu.JPG", @"活鲤鱼",
                    @"ic_product_jiajiyu.JPG", @"加吉鱼",
                    @"ic_product_changyu.JPG", @"昌鱼",
                    @"ic_product_wuchangyu.JPG", @"武昌鱼",
                    @"ic_product_daiyu.JPG", @"带鱼",
                    @"ic_product_daiyu.JPG", @"大带鱼",
                    @"ic_product_daiyu.JPG", @"小带鱼",
                    @"ic_product_daiyu.JPG", @"特带鱼",
                    @"ic_product_daiyu.JPG", @"国产带鱼",
                    @"ic_product_huayu.JPG", @"花鱼",
                    @"ic_product_huayu.JPG", @"进口花鱼",
                    @"ic_product_huangyu.JPG", @"黄鱼",
                    @"ic_product_huangyu.JPG", @"进口黄花鱼",
                    @"ic_product_huangyu.JPG", @"大黄花鱼",
                    @"ic_product_huangyu.JPG", @"大黄鱼",
                    @"ic_product_huangyu.JPG", @"小黄花鱼",
                    @"ic_product_huangyu.JPG", @"小黄鱼",
                    @"ic_product_pingyu.JPG", @"平鱼",
                    @"ic_product_pingyu.JPG", @"大平鱼",
                    @"ic_product_pingyu.JPG", @"小平鱼",
                    @"ic_product_hualian.JPG", @"花鲢",
                    @"ic_product_hualian.JPG", @"花鲢活鱼",
                    @"ic_product_bapiyu.JPG", @"扒皮鱼",
                    @"ic_product_bapiyu.JPG", @"三去扒皮鱼",
                    @"ic_product_bayu.JPG", @"巴鱼",
                    @"ic_product_lingyu.JPG", @"鲮鱼",
                    @"ic_product_lingyu.JPG", @"泰鲮鱼",
                    @"ic_product_wangyayu.JPG", @"汪丫鱼",
                    @"ic_product_xueyu.JPG", @"雪鱼",
                    @"ic_product_xueyu.JPG", @"无头雪鱼",
                    @"ic_product_biguanyu.JPG", @"笔管鱼",
                    @"ic_product_jingyu.JPG", @"鲭鱼",
                    @"ic_product_jingyu.JPG", @"进口鲭鱼",
                    @"ic_product_wangyu.JPG", @"王鱼",
                    @"ic_product_wangyu.JPG", @"西非王鱼",
                    @"ic_product_piankouyu.JPG", @"偏口鱼",
                    @"ic_product_piankouyu.JPG", @"进口偏口鱼",
                    @"ic_product_shibanyu.JPG", @"石斑鱼",
                    @"ic_product_daoyu.JPG", @"魛鱼",
                    @"ic_product_bayu1.JPG", @"鲅鱼",
                    @"ic_product_bayu1.JPG", @"鲐鲅鱼",
                    @"ic_product_guiyu1.JPG", @"鲑鱼",
                    @"ic_product_huaziyu.JPG", @"华子鱼",
                    @"ic_product_mingtaiyu.JPG", @"明太鱼",
                    @"ic_product_yanyu.JPG", @"燕鱼",
                    @"ic_product_shanyu.JPG", @"鳝鱼",
                    @"ic_product_shanyu.JPG", @"白鳝鱼",
                    @"ic_product_niqiu.JPG", @"泥鳅",
                    @"ic_product_nianyu.JPG", @"鲶鱼",
                    @"ic_product_nianyu.JPG", @"养殖鲶鱼",
                    @"ic_product_jiayu.JPG", @"甲鱼",
                    @"ic_product_jiayu.JPG", @"野生甲鱼",
                    @"ic_product_jiayu.JPG", @"人工甲鱼",
                    @"ic_product_wugui.JPG", @"乌龟",
                    @"ic_product_niuwa.JPG", @"牛蛙",
                    @"ic_product_shanbei.JPG", @"扇贝",
                    @"ic_product_haishen.JPG", @"海参",
                    @"ic_product_chenzi.JPG",@"蛏子",
                    @"ic_product_dongshuichan.JPG", @"冻水产",
                    @"ic_product_xiezi.JPG", @"蟹子",
                    @"ic_product_haimi.JPG", @"海米",
                    @"ic_product_haili.JPG", @"海蛎",
                    @"ic_product_hali.JPG",@"蛤蛎",
                    @"ic_product_hali.JPG", @"白蛤",
                    @"ic_product_hali.JPG", @"花蛤",
                    @"ic_product_xiezi.JPG", @"蟹",
                    @"ic_product_xiezi.JPG", @"梭子蟹",
                    @"ic_product_qingxie.JPG", @"青蟹",
                    @"ic_product_xiezi.JPG", @"花蟹",
                    @"ic_product_hailuo.JPG", @"海螺",
                    @"ic_product_youyu.JPG", @"鱿鱼",
                    @"ic_product_baoyu.JPG", @"鲍鱼",
                    @"ic_product_xiapi.JPG", @"虾皮",
                    @"ic_product_longxia.JPG", @"龙虾",
                    @"ic_product_longxia.JPG", @"龙虾尾",
                    @"ic_product_xia1.JPG", @"虾",
                    @"ic_product_xia1.JPG", @"基围虾",
                    @"ic_product_xia1.JPG", @"对虾",
                    @"ic_product_xia1.JPG", @"北极甜虾",
                    @"ic_product_xia1.JPG", @"大红虾",
                    @"ic_product_xia1.JPG", @"红虾",
                    @"ic_product_xia1.JPG", @"小河虾",
                    @"ic_product_xia1.JPG", @"中河虾",
                    @"ic_product_xia1.JPG", @"盐水虾",
                    @"ic_product_xia1.JPG", @"冻虾",
                    @"ic_product_xia1.JPG", @"小虾仁",
                    @"ic_product_zhima.JPG", @"芝麻",
                    @"ic_product_baizhima.JPG", @"白芝麻",
                    @"ic_product_zhima.JPG", @"黑芝麻",
                    @"ic_product_dami.JPG", @"大米",
                    @"ic_product_dami.JPG", @"粳米",
                    @"ic_product_dami.JPG", @"糯米",
                    @"ic_product_dami.JPG", @"籼米",
                    @"ic_product_dami.JPG", @"汉玉大米",
                    @"ic_product_dami.JPG", @"八宝米",
                    @"ic_product_dami.JPG", @"特一米",
                    @"ic_product_dami.JPG", @"江米",
                    @"ic_product_dami.JPG", @"标准米",
                    @"ic_product_dami.JPG", @"普通大米",
                    @"ic_product_dami.JPG", @"长粒大米",
                    @"ic_product_dami.JPG", @"长江米",
                    @"ic_product_dami.JPG", @"龙水大米",
                    @"ic_product_dami.JPG", @"东北大米",
                    @"ic_product_dami.JPG", @"协优米",
                    @"ic_product_dami.JPG", @"肥西大米",
                    @"ic_product_dami.JPG", @"杂交米",
                    @"ic_product_dami.JPG", @"圆江米",
                    @"ic_product_xiangmi.JPG", @"香米",
                    @"ic_product_heixiangmi.JPG", @"黑香米",
                    @"ic_product_xiangmi.JPG", @"泰国香米",
                    @"ic_product_gaoliangmi.JPG", @"高梁米",
                    @"ic_product_qiaomaimi.JPG", @"荞麦米",
                    @"ic_product_huangmi.JPG", @"黄米", 
                    @"ic_product_heimi.JPG", @"黑米",
                    @"ic_product_xiaomi.JPG", @"小米",
                    @"ic_product_chaomi.JPG", @"炒米",
                    @"ic_product_xiaomai.JPG", @"小麦",
                    @"ic_product_qiaomai.JPG", @"荞麦",
                    @"ic_product_yumi.JPG", @"玉米",
                    @"ic_product_yumi.JPG", @"东陵玉米",
                    @"ic_product_you.JPG", @"动物油",
                    @"ic_product_zhuyou.JPG", @"猪油",
                    @"ic_product_huangyou.JPG", @"黄油",
                    @"ic_product_mianfen.JPG", @"小麦粉",
                    @"ic_product_mianfen.JPG", @"米粉",
                    @"ic_product_nuomifen.JPG", @"糯米粉",
                    @"ic_product_huasheng.JPG", @"花生",
                    @"ic_product_huashengreng.JPG", @"花生仁",
                    @"ic_product_huashengmi.JPG", @"花生米",
                    @"ic_product_mianfen.JPG", @"面粉",
                    @"ic_product_mianfen.JPG", @"一级面粉",
                    @"ic_product_mianfen.JPG", @"莲花面粉",
                    @"ic_product_mianfen.JPG", @"神人助面粉",
                    @"ic_product_mianfen.JPG", @"特一级粉",
                    @"ic_product_mianfen.JPG", @"标准粉",
                    @"ic_product_mianfen.JPG", @"五得力面粉",
                    @"ic_product_mianfen.JPG", @"兰天富强粉",
                    @"ic_product_mianfen.JPG", @"面",
                    @"ic_product_mianfen.JPG", @"玉米面",
                    @"ic_product_mianfen.JPG", @"苦荞面",
                    @"ic_product_mianfen.JPG", @"攸面",
                    @"ic_product_mianfen.JPG", @"荞面",
                    @"ic_product_huangmimian.JPG", @"黄米面",
                    @"ic_product_mianfen.JPG", @"乔面",
                    @"ic_product_lvdou.JPG", @"豆类",
                    @"ic_product_lvdou.JPG", @"绿豆",
                    @"ic_product_huangdou.JPG", @"黄豆",
                    @"ic_product_hongdou.JPG", @"红豆",
                    @"ic_product_you.JPG", @"植物油",
                    @"ic_product_you.JPG", @"豆油",
                    @"ic_product_you.JPG", @"大豆油",
                    @"ic_product_you.JPG", @"棕榈油",
                    @"ic_product_you.JPG", @"花生油",
                    @"ic_product_you.JPG", @"鲁花纯正花生油",
                    @"ic_product_you.JPG", @"色拉油",
                    @"ic_product_you.JPG", @"菜油",
                    @"ic_product_you.JPG", @"菜籽油",
                    @"ic_product_you.JPG", @"葵花油",
                    @"ic_product_you.JPG", @"香油",
                    @"ic_product_mayou.JPG", @"麻油",
                    @"ic_product_you.JPG", @"胡麻油",
                    @"ic_product_fensi.JPG", @"粉",
                    @"ic_product_fensi.JPG", @"粉丝",
                    @"ic_product_fensi.JPG", @"粉条",
                    @"ic_product_fensi.JPG", @"凉粉",
                    @"ic_product_lvdougao.JPG", @"绿豆糕",
                    @"ic_product_lvdougao.JPG", @"昭通绿豆糕",
                    @"ic_product_rubing.JPG", @"乳饼",
                    @"ic_product_lizhi.JPG", @"荔枝",
                    @"ic_product_lizhi.JPG", @"白腊荔枝",
                    @"ic_product_lizhi.JPG", @"妃子笑荔枝",
                    @"ic_product_lizhi.JPG", @"黑叶荔枝",
                    @"ic_product_hongmaodan.JPG", @"红毛丹",
                    @"ic_product_boluo.JPG", @"菠萝",
                    @"ic_product_lizi.JPG", @"李子",
                    @"ic_product_lizi.JPG", @"布朗",
                    @"ic_product_lizi.JPG", @"红布朗",
                    @"ic_product_heibulin.JPG", @"黑布林",
                    @"ic_product_lizi.JPG", @"进口红李",
                    @"ic_product_li.JPG", @"梨",
                    @"ic_product_baili.JPG", @"白梨",
                    @"ic_product_li.JPG", @"酥梨",
                    @"ic_product_fengshuili.JPG", @"丰水梨",
                    @"ic_product_xiangli.JPG", @"香梨",
                    @"ic_product_xueli.JPG", @"雪梨",
                    @"ic_product_li.JPG", @"鸭梨",
                    @"ic_product_li.JPG", @"雪花梨",
                    @"ic_product_gongli.JPG", @"贡梨",
                    @"ic_product_caomei.JPG", @"草莓",
                    @"ic_product_youzi.JPG", @"柚",
                    @"ic_product_youzi.JPG", @"柚子",
                    @"ic_product_youzi.JPG", @"蜜柚",
                    @"ic_product_youzi.JPG", @"福柚",
                    @"ic_product_youzi.JPG", @"沙甜柚",
                    @"ic_product_huyou.JPG", @"常山胡柚",
                    @"ic_product_huyou.JPG", @"胡柚",
                    @"ic_product_xiangjiao.JPG", @"米蕉",
                    @"ic_example_pic.JPG", @"生津果",
                    @"ic_product_wuhuaguo.JPG", @"无花果",
                    @"ic_product_mati.JPG", @"马蹄",
                    @"ic_product_yezi.JPG", @"椰子",
                    @"ic_product_yangmei.JPG", @"杨梅",
                    @"ic_product_xinzi.JPG", @"杏子",
                    @"ic_product_ningmeng.JPG", @"柠檬",
                    @"ic_product_zhenzhugua.JPG", @"珍珠瓜",
                    @"ic_product_renshengguo.JPG", @"人参果",
                    @"ic_product_shanzha.JPG", @"山楂",
                    @"ic_product_hamigua.JPG", @"哈密瓜",
                    @"ic_product_mugua.JPG", @"木瓜",
                    @"ic_product_tiangua.JPG", @"甜瓜",
                    @"ic_product_longyan.JPG", @"龙眼",
                    @"ic_product_hongzao.JPG", @"枣",
                    @"ic_example_pic.JPG", @"金丝枣",
                    @"ic_product_hongzao.JPG", @"红枣",
                    @"ic_product_xianzao.JPG", @"鲜枣",
                    @"ic_example_pic.JPG", @"脆枣",
                    @"ic_example_pic.JPG", @"绿枣",
                    @"ic_example_pic.JPG", @"青枣",
                    @"ic_product_kuihuazi.JPG", @"葵花籽",
                    @"ic_product_mihoutao.JPG", @"猕猴桃",
                    @"ic_example_pic.JPG", @"金桔",
                    @"ic_product_ganzhe.JPG", @"甘蔗",
                    @"ic_product_ganzhe.JPG", @"黑甘蔗",
                    @"ic_product_ganzhe.JPG", @"竹蔗",
                    @"ic_product_yintao.JPG", @"樱桃",
                    @"ic_product_yintao.JPG", @"红樱桃",
                    @"ic_product_cheng.JPG", @"橙",
                    @"ic_product_cheng.JPG", @"甜橙",
                    @"ic_product_cheng.JPG", @"脐橙",
                    @"ic_product_cheng.JPG", @"冰糖橙",
                    @"ic_product_cheng.JPG", @"小甜橙",
                    @"ic_product_ganju.JPG", @"柑桔",
                    @"ic_product_ganju.JPG", @"贡柑",
                    @"ic_product_ganju.JPG", @"橘子",
                    @"ic_product_ganju.JPG", @"碰柑",
                    @"ic_product_ganju.JPG", @"蜜桔",
                    @"ic_product_ganju.JPG", @"沙糖桔",
                    @"ic_product_shiliu.JPG", @"石榴",
                    @"ic_product_shiliu.JPG", @"甜石榴",
                    @"ic_product_pipa.JPG", @"枇杷",
                    @"ic_product_pipa.JPG", @"蒙自大枇杷",
                    @"ic_product_shanzhu.JPG", @"山竹",
                    @"ic_product_shanzhu.JPG", @"进口山竹",
                    @"ic_product_banli.JPG", @"板栗",
                    @"ic_product_lizirou.JPG", @"栗子肉",
                    @"ic_product_liulian.JPG", @"榴莲",
                    @"ic_product_liulian.JPG", @"泰国榴莲",
                    @"ic_product_huolongguo.JPG", @"火龙果",
                    @"ic_product_huolongguo.JPG", @"进口火龙果",
                    @"ic_product_shengnvguo.JPG", @"圣女果",
                    @"ic_product_shengnvguo.JPG", @"水果番茄",
                    @"ic_product_xiangjiao.JPG", @"香蕉",
                    @"ic_product_xiangjiao.JPG", @"进口香蕉",
                    @"ic_product_shuimitao.JPG", @"桃",
                    @"ic_product_shuimitao.JPG", @"毛桃",
                    @"ic_product_shuimitao.JPG", @"水蜜桃",
                    @"ic_example_pic.JPG", @"蟠桃",
                    @"ic_example_pic.JPG", @"油桃",
                    @"ic_product_putao.JPG", @"葡萄",
                    @"ic_product_putao.JPG", @"巨峰葡萄",
                    @"ic_product_putao.JPG", @"玫瑰香葡萄",
                    @"ic_product_putao.JPG", @"白葡萄",
                    @"ic_product_putao.JPG", @"龙眼葡萄",
                    @"ic_product_pinguo.JPG", @"苹果",
                    @"ic_example_pic.JPG", @"蛇果",
                    @"ic_example_pic.JPG", @"进口蛇果",
                    @"ic_example_pic.JPG", @"红蛇果",
                    @"ic_product_pinguo.JPG", @"国光苹果",
                    @"ic_product_pinguo.JPG", @"红星苹果",
                    @"ic_product_pinguo.JPG", @"青苹果",
                    @"ic_product_pinguo.JPG", @"黄元帅苹果",
                    @"ic_product_pinguo.JPG", @"秦冠苹果",
                    @"ic_product_pinguo.JPG", @"红富士苹果",
                    @"ic_example_pic.JPG", @"花牛苹果",
                    @"ic_product_pinguo.JPG", @"姬娜果",
                    @"ic_product_pinguo.JPG", @"水晶红富士",
                    @"ic_product_pinguo.JPG", @"苹果甘肃",
                    @"ic_product_mangguo.JPG", @"芒果",
                    @"ic_product_mangguo.JPG", @"水仙芒果",
                    @"ic_product_mangguo.JPG", @"大芒果",
                    @"ic_product_mangguo.JPG", @"小芒果",
                    @"ic_product_mangguo.JPG", @"进口红芒",
                    @"ic_example_pic.JPG", @"手指芒",
                    @"ic_product_putao.JPG", @"提子",
                    @"ic_product_putao.JPG", @"红提子",
                    @"ic_product_putao.JPG", @"青提子",
                    @"ic_product_putao.JPG", @"无籽红提",
                    @"ic_product_putao.JPG", @"红提",
                    @"ic_product_xianggua.JPG", @"香瓜",
                    @"ic_product_baixianggua.JPG", @"白香瓜",
                    @"ic_product_huangxianggua.JPG", @"黄香瓜",
                    @"ic_product_huangjingua.JPG", @"黄金瓜",
                    @"ic_product_xianggua.JPG", @"伊丽沙白瓜",
                    @"ic_product_xigua.JPG", @"西瓜",
                    @"ic_product_xigua.JPG", @"无籽西瓜",
                    @"ic_product_xigua.JPG", @"黑美人",
                    @"ic_product_xigua.JPG", @"京欣",
                    @"ic_product_xigua.JPG", @"麒麟",
                    @"ic_product_xigua.JPG", @"特小凤瓜",
                    @"ic_product_xigua.JPG", @"早春红玉",
                    @"ic_product_ji.JPG", @"鸡",
                    @"ic_product_ji.JPG", @"柴鸡",
                    @"ic_product_ji.JPG", @"老母鸡",
                    @"ic_product_ji.JPG", @"乌鸡",
                    @"ic_product_ji.JPG", @"三黄鸡",
                    @"ic_product_ji.JPG", @"童子鸡",
                    @"ic_product_ji.JPG", @"西装鸡",
                    @"ic_product_ji.JPG", @"草公鸡",
                    @"ic_product_ji.JPG", @"蛋鸡",
                    @"ic_product_ji.JPG", @"母鸡活",
                    @"ic_product_ji.JPG", @"肉鸡",
                    @"ic_product_ji.JPG", @"三黄公鸡",
                    @"ic_product_ji.JPG", @"仔公鸡活",
                    @"ic_product_ji.JPG", @"仔鸡",
                    @"ic_product_ji.JPG", @"仔鸡肉鸡",
                    @"ic_product_ji.JPG", @"饲养鸡",
                    @"ic_product_ji.JPG", @"鸡肉",
                    @"ic_product_ji.JPG", @"白条鸡",
                    @"ic_product_ji.JPG", @"冻光鸡",
                    @"ic_product_ji.JPG", @"鸡胸肉",
                    @"ic_product_ji.JPG", @"鸡翅",
                    @"ic_product_ji.JPG", @"散鸡翅",
                    @"ic_product_ji.JPG", @"散鸡腿",
                    @"ic_product_dan.JPG",@"鸡蛋",
                    @"ic_product_dan.JPG",@"红皮鸡蛋",
                    @"ic_product_dan.JPG",@"土鸡蛋",
                    @"ic_product_dan.JPG",@"洋鸡蛋",
                    @"ic_product_dan.JPG", @"草鸡蛋",
                    @"ic_product_anchundan.JPG", @"鹌鹑蛋",
                    @"ic_product_e.JPG", @"鹅",
                    @"ic_product_e.JPG", @"活鹅",
                    @"ic_product_e.JPG", @"老鹅",
                    @"ic_product_zhu.JPG",@"猪",
                    @"ic_product_zhu.JPG",@"仔猪",
                    @"ic_product_zhu.JPG",@"猪肉",
                    @"ic_product_zhu.JPG",@"肥膘",
                    @"ic_product_zhu.JPG",@"鲜肉",
                    @"ic_product_zhu.JPG",@"三号肉",
                    @"ic_product_zhu.JPG",@"腿肉",
                    @"ic_product_zhu.JPG",@"纯瘦肉",
                    @"ic_product_zhu.JPG",@"里脊",
                    @"ic_product_zhu.JPG",@"猎腿肉",
                    @"ic_product_zhu.JPG",@"大圆骨",
                    @"ic_product_zhu.JPG",@"肥肉",
                    @"ic_product_zhu.JPG",@"排骨",
                    @"ic_product_zhu.JPG",@"前夹肉",
                    @"ic_product_zhu.JPG",@"圆骨",
                    @"ic_product_zhu.JPG",@"后腿肉",
                    @"ic_product_zhu.JPG",@"后座肉",
                    @"ic_product_zhu.JPG",@"瘦肉",
                    @"ic_product_zhu.JPG",@"前腿肉",
                    @"ic_product_zhu.JPG",@"白条猪",
                    @"ic_product_zhu.JPG",@"白条肉",
                    @"ic_product_zhu.JPG",@"猪大肠",
                    @"ic_product_zhu.JPG", @"猪大排肌肉",
                    @"ic_product_zhu.JPG", @"猪肚",
                    @"ic_product_zhu.JPG",@"猪肺",
                    @"ic_product_zhu.JPG",@"猪肝",
                    @"ic_product_zhu.JPG",@"猪后腿肌肉",
                    @"ic_product_zhu.JPG",@"猪颈背肌肉",
                    @"ic_product_zhu.JPG",@"猪前腿肌肉",
                    @"ic_product_zhu.JPG",@"猪肾",
                    @"ic_product_zhu.JPG",@"猪小肠", 
                    @"ic_product_zhu.JPG",@"猪心", 
                    @"ic_product_zhu.JPG",@"小排",
                    @"ic_product_zhu.JPG",@"精选猪肉",
                    @"ic_product_zhu.JPG",@"鲜猪肉",
                    @"ic_product_zhu.JPG",@"精瘦肉",
                    @"ic_product_zhu.JPG",@"后座统货",
                    @"ic_product_zhu.JPG",@"五花肉",
                    @"ic_product_zhu.JPG",@"精猪肉",
                    @"ic_product_zhu.JPG",@"卤猪耳",
                    @"ic_product_zhu.JPG",@"白条猪肉",
                    @"ic_product_zhu.JPG",@"猪腿肉",
                    @"ic_product_zhu.JPG",@"猪五花肉",
                    @"ic_product_zhu.JPG",@"猪小排",
                    @"ic_product_zhu.JPG",@"猪排骨",
                    @"ic_product_zhu.JPG",@"猪排", 
                    @"ic_product_zhu.JPG",@"猪后腿",
                    @"ic_product_zhu.JPG",@"猪肠",
                    @"ic_product_zhu.JPG",@"猪精肉",
                    @"ic_product_tuzi.JPG", @"兔子",
                     @"ic_product_tuzi.JPG",@"活兔",
                    @"ic_product_ya.JPG",@"鸭",
                     @"ic_product_ya.JPG",@"老鸭",
                     @"ic_product_ya.JPG",@"鸭肉",
                     @"ic_product_ya.JPG",@"冻光鸭",
                    @"ic_product_ya.JPG",@"白条鸭",
                    @"ic_product_ya.JPG",@"烤鸭",
                    @"ic_product_yadan.JPG",@"鸭蛋",
                    @"ic_product_yadan.JPG", @"咸鸭蛋",
                    @"ic_product_yangrou.JPG", @"羊",
                    @"ic_product_yangrou.JPG", @"活羊",
                    @"ic_product_yangrou.JPG", @"羊肉",
                    @"ic_product_yangrou.JPG", @"山羊肉",
                    @"ic_product_yangrou.JPG", @"精卷大羊肉",
                    @"ic_product_yangrou.JPG", @"精卷羔羊肉",
                    @"ic_product_yangrou.JPG", @"绵羊肉",
                    @"ic_product_yangrou.JPG",@"鲜羊肉",
                    @"ic_product_yangrou.JPG",@"羊排",
                    @"ic_product_yangrou.JPG", @"羊肉片",
                    @"ic_product_yangrou.JPG",@"羊小腿",
                    @"ic_product_chuanshanjia.JPG",@"穿山甲",
                    @"ic_product_niurou.JPG",@"牛肉",
                    @"ic_product_niurou.JPG",@"鲜牛肉",
                    @"ic_product_niurou.JPG",@"新鲜去骨",
                    @"ic_product_niurou.JPG",@"牛排",
                    @"ic_product_niurou.JPG",@"生牛肉",
                    @"ic_product_niurou.JPG",@"熟牛肉",
                    @"ic_product_niurou.JPG",@"黄牛肉",
                    @"ic_product_xuelianguo.JPG",@"雪莲果",
                    @"ic_product_fanshu.JPG",@"番薯",
                    @"ic_product_fanshu.JPG",@"良薯",
                    @"ic_product_fanshu.JPG", @"土豆",
                    @"ic_product_nangua.JPG",@"南瓜",
                    @"ic_product_nangua.JPG",@"老南瓜",
                    @"ic_product_mogu.JPG",@"蘑菇",
                    @"ic_product_bailinggu.JPG",@"白灵菇",
                    @"ic_product_pinggu.JPG",@"平菇",
                    @"ic_product_haixiangu.JPG",@"海鲜菇",
                    @"ic_product_baigu.JPG",@"白菇",
                    @"ic_product_xiuzhenggu.JPG",@"袖珍菇",
                    @"ic_product_koumo.JPG",@"口蘑",
                    @"ic_product_xingbaogu.JPG", @"杏鲍菇",
                     @"ic_product_xianggu.JPG", @"香菇",
                    @"ic_example_pic.JPG",@"猴头菇",
                    @"ic_example_pic.JPG",@"凤尾菇",
                    @"ic_example_pic.JPG",@"金针菇",
                    @"ic_product_jituigu.JPG",@"鸡腿菇",
                    @"ic_product_xianggu.JPG",@"草菇",
                    @"ic_example_pic.JPG", @"茶树菇",
                    @"ic_example_pic.JPG",@"慈菇",
                    @"ic_product_luobo.JPG",@"萝卜",
                    @"ic_product_luobo.JPG", @"白萝卜",
                    @"ic_product_luobo.JPG",@"青萝卜",
                    @"ic_example_pic.JPG", @"樱桃萝卜",
                    @"ic_product_luobo.JPG", @"大萝卜",
                    @"ic_product_luobo.JPG", @"象牙萝卜",
                    @"ic_product_huluobo.JPG",@"胡萝卜",
                    @"ic_product_hongluobo.JPG",@"红萝卜",
                    @"ic_product_luobo,png",@"心灵美萝卜"
                    @"ic_product_luobomiao.JPG",@"萝卜苗",
                    @"ic_product_suan.JPG",@"蒜",
                    @"ic_product_suan.JPG",@"蒜薹",
                    @"ic_product_suan.JPG",@"本地大蒜",
                    @"ic_product_hongsuan.JPG"@"红蒜",
                    @"ic_product_suanmiao.JPG",@"蒜苗",
                    @"ic_product_suan.JPG",@"蒜黄",
                    @"ic_product_suan.JPG",@"白蒜",
                    @"ic_product_suanzi.JPG",@"蒜子",
                    @"ic_product_suanmi.JPG",@"蒜米",
                    @"ic_product_bocai.JPG",@"菠菜",
                    @"ic_product_caihua.JPG",@"菜花",
                    @"ic_product_caihua.JPG",@"绿菜花",
                    @"ic_product_caihua.JPG",@"散花菜",
                    @"ic_product_baicaihua.JPG",@"白菜花",
                     @"ic_product_qiezi.JPG",@"茄子",
                    @"ic_product_changqiezi.JPG",@"长茄子",
                     @"ic_product_lvqiezi.JPG",@"绿茄子",
                    @"ic_product_qiezi.JPG",@"圆茄子",
                    @"ic_product_qiezi.JPG",@"紫长茄",
                    @"ic_product_baicai.JPG",@"白菜",
                    @"ic_product_baicai.JPG",@"大白菜",
                    @"ic_product_baicai.JPG",@"黑白菜",
                    @"ic_product_baicai.JPG",@"毛白菜",
                    @"ic_product_baicai.JPG",@"长白菜",
                    @"ic_product_baicai.JPG",@"奶白菜",
                    @"ic_product_baicai.JPG",@"白菜芯",
                    @"ic_product_baicai.JPG",@"白菜薹",
                    @"ic_product_baicai.JPG",@"白菜苗",
                    @"ic_product_baocai.JPG",@"甘兰",
                    @"ic_product_baocai.JPG",@"包菜",
                    @"ic_product_baocai.JPG",@"小包菜",
                    @"ic_product_baocai.JPG",@"大包菜",
                    @"ic_product_baocai.JPG",@"平包菜",
                    @"ic_product_baocai.JPG",@"紫甘兰",
                    @"ic_product_lianhuabai.JPG",@"莲花白",
                    @"ic_product_wawacai.JPG",@"娃娃菜",
                    @"ic_product_huangxincai.JPG",@"黄心菜",
                    @"ic_product_qingcai.JPG",@"青菜",
                    @"ic_product_qingcai.JPG",@"菜心",
                    @"ic_product_qingcai.JPG",@"小白菜",
                    @"ic_product_qingcai.JPG",@"小青菜",
                    @"ic_product_xuelihong.JPG",@"雪里红",
                    @"ic_product_gaicai.JPG",@"芥菜",
                    @"ic_product_gaicai.JPG",@"大芥菜",
                    @"ic_product_jiucai.JPG",@"韭菜",
                    @"ic_product_jiucaihua.JPG",@"韭菜花",
                    @"ic_product_jiuhuang.JPG",@"韭黄",
                    @"ic_product_kongxincai.JPG",@"空心菜",
                    @"ic_product_shengcai.JPG",@"生菜",
                    @"ic_product_shengcai.JPG",@"西生菜",
                    @"ic_product_maicai.JPG",@"麦菜",
                     @"ic_product_xiyangcai.JPG",@"西洋菜",
                    @"ic_product_chuncai1.JPG",@"春菜",
                    @"ic_product_ercai.JPG",@"儿菜",
                    @"ic_product_shixiangcai.JPG",@"十香菜",
                    @"ic_product_shixiangcai.JPG",@"荠菜",
                    @"ic_product_cong.JPG",@"葱",
                    @"ic_product_cong.JPG",@"小葱",
                    @"ic_product_cong.JPG",@"生葱",
                    @"ic_product_yangcong.JPG",@"洋葱",
                    @"ic_product_lajiao.JPG",@"椒",
                    @"ic_product_qingjiao.JPG",@"青椒",
                    @"ic_product_lajiao.JPG",@"尖椒",
                    @"ic_product_lajiao.JPG",@"辣椒",
                    @"ic_product_lajiao.JPG",@"红辣椒",
                    @"ic_product_qinglajiao.JPG",@"青辣椒",
                    @"ic_product_lajiao.JPG",@"青海椒",
                    @"ic_product_lajiao.JPG",@"薄皮椒",
                     @"ic_product_zhitianjiao.JPG",@"指天椒",
                    @"ic_product_lajiao.JPG",@"杭椒",
                    @"ic_product_lajiao.JPG",@"大红椒",
                    @"ic_product_hongcaijiao.JPG",@"红彩椒",
                    @"ic_product_haihuajiao.JPG",@"海花椒",
                    @"ic_product_xijiao.JPG",@"西椒",
                    @"ic_product_lajiao.JPG",@"红椒",
                    @"ic_product_lajiao.JPG",@"红尖椒",
                    @"ic_product_jiang.JPG",@"姜",
                    @"ic_product_jiang.JPG",@"鲜姜",
                    @"ic_product_jiang.JPG",@"子姜",
                    @"ic_example_pic.JPG",@"茼蒿",
                    @"ic_product_wandou.JPG",@"豌豆",
                     @"ic_product_wandou.JPG",@"豌豆米",
                    @"ic_product_wandoujian.JPG",@"豌豆尖",
                    @"ic_product_wandou.JPG",@"豆角",
                    @"ic_product_wandou.JPG",@"青豆",
                    @"ic_product_wandou.JPG",@"河南豆",
                    @"ic_product_wandou.JPG",@"鲜葫豆",
                    @"ic_product_biandou.JPG",@"扁豆",
                    @"ic_product_baidou.JPG",@"白豆",
                    @"ic_product_wandou.JPG",@"甜豆",
                    @"ic_product_sijidou.JPG",@"四季豆",
                    @"ic_example_pic.JPG",@"蚕豆",
                    @"ic_example_pic.JPG",@"蚕豆米",
                    @"ic_example_pic.JPG",@"芸豆",
                    @"ic_example_pic.JPG",@"豇豆",
                    @"ic_product_wandou.JPG",@"豌豆角",
                    @"ic_product_wandou.JPG",@"去皮碗豆",
                    @"ic_example_pic.JPG",@"长豆角",
                    @"ic_example_pic.JPG",@"架豆角",
                    @"ic_example_pic.JPG",@"毛豆",
                    @"ic_example_pic.JPG",@"毛豆米",
                     @"ic_product_wosun.JPG",@"莴笋",
                    @"ic_product_xihongshi.JPG",@"西红柿",
                    @"ic_product_xihulu.JPG",@"西葫芦",
                    @"ic_example_pic.JPG",@"笋瓜",
                    @"ic_example_pic.JPG",@"笋",
                    @"ic_example_pic.JPG",@"冬笋",
                    @"ic_example_pic.JPG",@"芦笋",
                    @"ic_example_pic.JPG",@"笋片",
                    @"ic_product_muer.JPG",@"木耳",
                    @"ic_product_muer.JPG",@"鲜木耳",
                    @"ic_example_pic.JPG",@"银耳",
                    @"ic_product_huzi.JPG",@"瓠子",
                    @"ic_product_ou.JPG",@"藕",
                    @"ic_product_ou.JPG",@"野藕",
                    @"ic_example_pic.JPG",@"藕芯菜",
                    @"ic_example_pic.JPG",@"芹菜",
                    @"ic_example_pic.JPG",@"外国芹",
                    @"ic_example_pic.JPG",@"西芹",
                    @"ic_example_pic.JPG",@"芹芽",
                    @"ic_example_pic.JPG",@"芹菜芽",
                    @"ic_example_pic.JPG",@"苋菜",
                     @"ic_product_xiangcai.JPG",@"香菜",
                    @"ic_product_xiangchun.JPG",@"香椿",
                    @"ic_example_pic.JPG",@"香椿枒",
                    @"ic_product_youcai.JPG",@"油菜",
                    @"ic_product_youcai.JPG",@"红油菜",
                    @"ic_product_youcai.JPG",@"苔白油菜",
                    @"ic_product_youmaicai.JPG",@"油麦菜",
                    @"ic_product_yumi.JPG",@"玉米",
                    @"ic_product_yumi.JPG",@"英红玉米",
                    @"ic_product_yunai.JPG",@"芋艿",
                    @"ic_product_fanshu.JPG",@"小芋头",
                    @"ic_product_fanshu.JPG",@"山芋洋芋",
                    @"ic_product_fanshu.JPG",@"荔蒲芋",
                    @"ic_product_fanshu.JPG",@"香芋",
                    @"ic_product_douya.JPG",@"豆芽",
                    @"ic_product_douya.JPG",@"黄豆芽",
                    @"ic_product_lvdouya.JPG",@"绿豆芽",
                    @"ic_product_shanyao.JPG",@"山药",
                    @"ic_product_youmaicai.JPG",@"苦麦菜",
                    @"ic_product_chancai.JPG",@"潺菜",
                    @"ic_product_niubang.JPG",@"牛蒡",
                     @"ic_example_pic.JPG",@"蕃元茜",
                    @"ic_product_gouqiye.JPG",@"枸杞叶",
                    @"ic_product_datoucai.JPG",@"菜头",
                    @"ic_product_gailan.JPG",@"芥兰",
                    @"ic_example_pic.JPG",@"芥兰头",
                    @"ic_product_jiaobai.JPG",@"茭白",
                     @"ic_product_luhao.JPG",@"芦蒿",
                    @"ic_product_maoercai.JPG",@"猫耳菜",
                    @"ic_product_haidai.JPG",@"海带",
                    @"ic_product_yancaigeng.JPG",@"腌菜梗",
                    @"ic_product_huanggua.JPG",@"青瓜",
                    @"ic_product_huanggua.JPG", @"黄瓜",
                    @"ic_product_huanggua.JPG",@"小黄瓜",
                    @"ic_product_huanggua.JPG",@"水黄瓜",
                     @"ic_product_huanggua.JPG",@"旱黄瓜",
                    @"ic_product_huanggua.JPG",@"光皮黄瓜",
                    @"ic_product_jiegua.JPG",@"生瓜",
                    @"ic_product_jiegua.JPG",@"节瓜",
                    @"ic_product_jiegua.JPG",@"甫瓜",
                    @"ic_product_foshougua.JPG",@"佛手瓜",
                    @"ic_product_donggua.JPG",@"冬瓜",
                    @"ic_product_donggua.JPG",@"青冬瓜",
                    @"ic_product_sigua.JPG",@"丝瓜",
                    @"ic_product_kugua.JPG",@"苦瓜",
                    @"ic_product_xueyu1.JPG",@"鳕鱼",
                    @"ic_product_yanyu1.JPG",@"燕鱼",
                    @"ic_product_ziganlan.JPG",@"紫甘蓝",
                    @"ic_product_yilishabaigua.JPG",@"伊丽莎白瓜", nil];

}

+ (NSString *)getProductImageName:(NSString *)product
{
    return [myProductMap objectForKey:product];
}


@end
