[General]
SyntaxVersion=2
MacroID=3f1e0d02-3591-4461-aead-f3fdd3e337b1
[Comment]
������ǰ�������8.0���Ƴ���ȫ�¹���
�����԰��Լ����õĺ������ӳ���д����������úܶ���ű�ȥ����
����������������ö���ű�����һ������޸�һ���͵����޸Ķദ
Ŀǰ����⹦�ܻ��ڲ��Ե��У����κν�������ڰ���������̳�������ַ��http://bbs.ajjl.cn
******ע�⣡���ǹٷ��ṩ������⣬�����޸ģ������Ժ󰴼���������ʱ���������޸ġ�******//
******          ������������⣬������������Ҽ�ѡ���½��������            ******//

[Script]
Function �ṹ��������(����,��������)
    //����="100=A|50=B|1=C|0=D|10=E|20=F|12=G|21=H"
    //����=Split(����,"|")
    //���ӣ�Msgbox lib.�㷨.�ṹ��������(����,0)
    //�﷨��ʽ������() = "���ִ�С=ֵ"
    //���飺NB_PaiXu(0) = "200=A"
    //�������ͣ�[0ȫ��1��С2���]
    Dim Int_A,Int_B,Int_Num,Int_Len,A_Str,Int_Temp
    //��������������������������������������������ʼ��ֵ
    Int_A = 0: Int_Num = UBound(����)
    For Int_A=0 TO UBound(����) - 1
        Int_B = Int_A
        For Int_Len=0 To Int_Num - Int_A 
            //�������������������������������������ݡ�=���ŷ��룬���д�С�ж�
            A_Str = Split(����(Int_A), "="): B_Str = Split(����(Int_B), "=")
            If CSng(A_Str(0)) > CSng(B_Str(0)) Then
                Int_Temp = ����(Int_A): ����(Int_A) = ����(Int_B): ����(Int_B) = Int_Temp
            End If 
            Int_B = Int_B + 1
        Next 
    Next 
    If �������� = 0 Then
        //��������������������������������������������
        �ṹ�������� = Join(����)
    ElseIf �������� = 1 Then
        //��������������������������������������������Сֵ
        �ṹ�������� = ����(0)
    ElseIf �������� = 2 Then
        //���������������������������������������������ֵ
        �ṹ�������� = ����(Int_Num)
    End If 
End Function   
Function ��ȡ�ִ�������������(�ַ���)
    //MsgBox lib.�㷨.��ȡ�ִ�������������("dfghhj12dsfg3.hgk54dsfg67-45678")
    Dim TQstring    
    TQstring = "Dim rExp, shuzi" & vbCrLf    
    TQstring = TQstring & "shuzi = """"" & vbCrLf 
    TQstring = TQstring & "Set rExp = CreateObject(""VBScript.RegExp"")" & vbCrLf 
    TQstring = TQstring & "rExp.Pattern = ""\d+""" & vbCrLf    //���ù���ģʽ
    TQstring = TQstring & "rExp.Global = True" & vbCrLf        //����ȫ�ֿ�����
    TQstring = TQstring & "Dim Num, Nums" & vbCrLf             //�������
    TQstring = TQstring & "Set Nums = rExp.Execute(""" & �ַ��� & """)" & vbCrLf   //ִ������  
    TQstring = TQstring & "For Each Num In Nums" & vbCrLf      //����ƥ�伯��
    TQstring = TQstring & "    shuzi = shuzi & Num" & vbCrLf  
    TQstring = TQstring & "next" & vbCrLf  
    TQstring = TQstring & "Set rExp = Nothing"
    Execute TQstring 
    ��ȡ�ִ������������� = shuzi
End Function
Function ��ȡ����ƴ������ĸ(���ĺ���)
    //���ӣ�MsgBox lib.�㷨.��ȡ����ƴ������ĸ("����һֻ�㣡")
    Dim ƴ������ĸ,��������,���ֱ���,����ĸ,i
    ƴ������ĸ=""
    For i=0 To Len(���ĺ���)-1
        ��������=Mid(���ĺ���,i+1,1)    
        ���ֱ��� = 65536 + Asc(��������)
        ����ĸ = ""
        If (���ֱ��� >= 45217 And ���ֱ��� <= 45252)
            ����ĸ = "A"
        ElseIf (���ֱ��� >= 45253 And ���ֱ��� <= 45760)
            ����ĸ = "B"
        ElseIf (���ֱ��� >= 45761 And ���ֱ��� <= 46317)
            ����ĸ = "C"
        ElseIf (���ֱ��� >= 46318 And ���ֱ��� <= 46825)
            ����ĸ = "D"
        ElseIf (���ֱ��� >= 46826 And ���ֱ��� <= 47009)
            ����ĸ = "E"
        ElseIf (���ֱ��� >= 47010 And ���ֱ��� <= 47296)
            ����ĸ = "F"
        ElseIf (���ֱ��� >= 47297 And ���ֱ��� <= 47613)   
            ����ĸ = "G"  
        ElseIf (���ֱ��� >= 47614 And ���ֱ��� <= 48118)   
            ����ĸ = "H"  
        ElseIf (���ֱ��� >= 48119 And ���ֱ��� <= 49061)   
            ����ĸ = "J"  
        ElseIf (���ֱ��� >= 49062 And ���ֱ��� <= 49323)   
            ����ĸ = "K"  
        ElseIf (���ֱ��� >= 49324 And ���ֱ��� <= 49895)   
            ����ĸ = "L"  
        ElseIf (���ֱ��� >= 49896 And ���ֱ��� <= 50370)   
            ����ĸ = "M"  
        ElseIf (���ֱ��� >= 50371 And ���ֱ��� <= 50613)   
            ����ĸ = "N"  
        ElseIf (���ֱ��� >= 50614 And ���ֱ��� <= 50621)   
            ����ĸ = "O"  
        ElseIf (���ֱ��� >= 50622 And ���ֱ��� <= 50905)   
            ����ĸ = "P"  
        ElseIf (���ֱ��� >= 50906 And ���ֱ��� <= 51386)   
            ����ĸ = "Q"  
        ElseIf (���ֱ��� >= 51387 And ���ֱ��� <= 51445)   
            ����ĸ = "R"  
        ElseIf (���ֱ��� >= 51446 And ���ֱ��� <= 52217)   
            ����ĸ = "S"  
        ElseIf (���ֱ��� >= 52218 And ���ֱ��� <= 52697)   
            ����ĸ = "T"  
        ElseIf (���ֱ��� >= 52698 And ���ֱ��� <= 52979)   
            ����ĸ = "W"  
        ElseIf (���ֱ��� >= 52980 And ���ֱ��� <= 53640)   
            ����ĸ = "X"  
        ElseIf (���ֱ��� >= 53689 And ���ֱ��� <= 54480)   
            ����ĸ = "Y"  
        ElseIf (���ֱ��� >= 54481 And ���ֱ��� <= 55289)   
            ����ĸ = "Z"  
        EndIf  
        ƴ������ĸ = ƴ������ĸ & ����ĸ
    Next
    ��ȡ����ƴ������ĸ = ƴ������ĸ
End Function     
Function ���ĺ���תƴ��(���ĺ���)
    //���ӣ�MsgBox lib.�㷨.���ĺ���תƴ��("����һֻ�㣡")
    Dim ƴ������(395)
    ƴ������(0) = "A=-20319"
    ƴ������(1) = "Ai=-20317"
    ƴ������(2) = "An=-20304"
    ƴ������(3) = "Ang=-20295"
    ƴ������(4) = "Ao=-20292"

    ƴ������(5) = "Ba=-20283"
    ƴ������(6) = "Bai=-20265"
    ƴ������(7) = "Ban=-20257"
    ƴ������(8) = "Bang=-20242"
    ƴ������(9) = "Bao=-20230"
    ƴ������(10) = "Bei=-20051"
    ƴ������(11) = "Ben=-20036"
    ƴ������(12) = "Beng=-20032"
    ƴ������(13) = "Bi=-20026"
    ƴ������(14) = "Bian=-20002"
    ƴ������(15) = "Biao=-19990"
    ƴ������(16) = "Bie=-19986"
    ƴ������(17) = "Bin=-19982"
    ƴ������(18) = "Bing=-19976"
    ƴ������(19) = "Bo=-19805"
    ƴ������(20) = "Bu=-19784"

    ƴ������(21) = "Ca=-19775"
    ƴ������(22) = "Cai=-19774"
    ƴ������(23) = "Can=-19763"
    ƴ������(24) = "Cang=-19756"
    ƴ������(25) = "Cao=-19751"
    ƴ������(26) = "Ce=-19746"
    ƴ������(27) = "Ceng=-19741"
    ƴ������(28) = "Cha=-19739"
    ƴ������(29) = "Chai=-19728"
    ƴ������(30) = "Chan=-19725"
    ƴ������(31) = "Chang=-19715"
    ƴ������(32) = "Chao=-19540"
    ƴ������(33) = "Che=-19531"
    ƴ������(34) = "Chen=-19525"
    ƴ������(35) = "Cheng=-19515"
    ƴ������(36) = "Chi=-19500"
    ƴ������(37) = "Chong=-19484"
    ƴ������(38) = "Chou=-19479"
    ƴ������(39) = "Chu=-19467"
    ƴ������(40) = "Chuai=-19289"
    ƴ������(41) = "Chuan=-19288"
    ƴ������(42) = "Chuang=-19281"
    ƴ������(43) = "Chui=-19275"
    ƴ������(44) = "Chun=-19270"
    ƴ������(45) = "Chuo=-19263"
    ƴ������(46) = "Ci=-19261"
    ƴ������(47) = "Cong=-19249"
    ƴ������(48) = "Cou=-19243"
    ƴ������(49) = "Cu=-19242"
    ƴ������(50) = "Cuan=-19238"
    ƴ������(51) = "Cui=-19235"
    ƴ������(52) = "Cun=-19227"
    ƴ������(53) = "Cuo=-19224"

    ƴ������(54) = "Da=-19218"
    ƴ������(55) = "Dai=-19212"
    ƴ������(56) = "Dan=-19038"
    ƴ������(57) = "Dang=-19023"
    ƴ������(58) = "Dao=-19018"
    ƴ������(59) = "De=-19006"
    ƴ������(60) = "Deng=-19003"
    ƴ������(61) = "Di=-18996"
    ƴ������(62) = "Dian=-18977"
    ƴ������(63) = "Diao=-18961"
    ƴ������(64) = "Die=-18952"
    ƴ������(65) = "Ding=-18783"
    ƴ������(66) = "Diu=-18774"
    ƴ������(67) = "Dong=-18773"
    ƴ������(68) = "Dou=-18763"
    ƴ������(69) = "Du=-18756"
    ƴ������(70) = "Duan=-18741"
    ƴ������(71) = "Dui=-18735"
    ƴ������(72) = "Dun=-18731"
    ƴ������(73) = "Duo=-18722"

    ƴ������(74) = "E=-18710"
    ƴ������(75) = "En=-18697"
    ƴ������(76) = "Er=-18696"

    ƴ������(77) = "Fa=-18526"
    ƴ������(78) = "Fan=-18518"
    ƴ������(79) = "Fang=-18501"
    ƴ������(80) = "Fei=-18490"
    ƴ������(81) = "Fen=-18478"
    ƴ������(82) = "Feng=-18463"
    ƴ������(83) = "Fo=-18448"
    ƴ������(84) = "Fou=-18447"
    ƴ������(85) = "Fu=-18446"

    ƴ������(86) = "Ga=-18239"
    ƴ������(87) = "Gai=-18237"
    ƴ������(88) = "Gan=-18231"
    ƴ������(89) = "Gang=-18220"
    ƴ������(90) = "Gao=-18211"
    ƴ������(91) = "Ge=-18201"
    ƴ������(92) = "Gei=-18184"
    ƴ������(93) = "Gen=-18183"
    ƴ������(94) = "Geng=-18181"
    ƴ������(95) = "Gong=-18012"
    ƴ������(96) = "Gou=-17997"
    ƴ������(97) = "Gu=-17988"
    ƴ������(98) = "Gua=-17970"
    ƴ������(99) = "Guai=-17964"
    ƴ������(100) = "Guan=-17961"
    ƴ������(101) = "Guang=-17950"
    ƴ������(102) = "Gui=-17947"
    ƴ������(103) = "Gun=-17931"
    ƴ������(104) = "Guo=-17928"

    ƴ������(105) = "Ha=-17922"
    ƴ������(106) = "Hai=-17759"
    ƴ������(107) = "Han=-17752"
    ƴ������(108) = "Hang=-17733"
    ƴ������(109) = "Hao=-17730"
    ƴ������(110) = "He=-17721"
    ƴ������(111) = "Hei=-17703"
    ƴ������(112) = "Hen=-17701"
    ƴ������(113) = "Heng=-17697"
    ƴ������(114) = "Hong=-17692"
    ƴ������(115) = "Hou=-17683"
    ƴ������(116) = "Hu=-17676"
    ƴ������(117) = "Hua=-17496"
    ƴ������(118) = "Huai=-17487"
    ƴ������(119) = "Huan=-17482"
    ƴ������(120) = "Huang=-17468"
    ƴ������(121) = "Hui=-17454"
    ƴ������(122) = "Hun=-17433"
    ƴ������(123) = "Huo=-17427"

    ƴ������(124) = "Ji=-17417"
    ƴ������(125) = "Jia=-17202"
    ƴ������(126) = "Jian=-17185"
    ƴ������(127) = "Jiang=-16983"
    ƴ������(128) = "Jiao=-16970"
    ƴ������(129) = "Jie=-16942"
    ƴ������(130) = "Jin=-16915"
    ƴ������(131) = "Jing=-16733"
    ƴ������(132) = "Jiong=-16708"
    ƴ������(133) = "Jiu=-16706"
    ƴ������(134) = "Ju=-16689"
    ƴ������(135) = "Juan=-16664"
    ƴ������(136) = "Jue=-16657"
    ƴ������(137) = "Jun=-16647"

    ƴ������(138) = "Ka=-16474"
    ƴ������(139) = "Kai=-16470"
    ƴ������(140) = "Kan=-16465"
    ƴ������(141) = "Kang=-16459"
    ƴ������(142) = "Kao=-16452"
    ƴ������(143) = "Ke=-16448"
    ƴ������(144) = "Ken=-16433"
    ƴ������(145) = "Keng=-16429"
    ƴ������(146) = "Kong=-16427"
    ƴ������(147) = "Kou=-16423"
    ƴ������(148) = "Ku=-16419"
    ƴ������(149) = "Kua=-16412"
    ƴ������(150) = "Kuai=-16407"
    ƴ������(151) = "Kuan=-16403"
    ƴ������(152) = "Kuang=-16401"
    ƴ������(153) = "Kui=-16393"
    ƴ������(154) = "Kun=-16220"
    ƴ������(155) = "Kuo=-16216"

    ƴ������(156) = "La=-16212"
    ƴ������(157) = "Lai=-16205"
    ƴ������(158) = "Lan=-16202"
    ƴ������(159) = "Lang=-16187"
    ƴ������(160) = "Lao=-16180"
    ƴ������(161) = "Le=-16171"
    ƴ������(162) = "Lei=-16169"
    ƴ������(163) = "Leng=-16158"
    ƴ������(164) = "Li=-16155"
    ƴ������(165) = "Lia=-15959"
    ƴ������(166) = "Lian=-15958"
    ƴ������(167) = "Liang=-15944"
    ƴ������(168) = "Liao=-15933"
    ƴ������(169) = "Lie=-15920"
    ƴ������(170) = "Lin=-15915"
    ƴ������(171) = "Ling=-15903"
    ƴ������(172) = "Liu=-15889"
    ƴ������(173) = "Long=-15878"
    ƴ������(174) = "Lou=-15707"
    ƴ������(175) = "Lu=-15701"
    ƴ������(176) = "Lv=-15681"
    ƴ������(177) = "Luan=-15667"
    ƴ������(178) = "Lue=-15661"
    ƴ������(179) = "Lun=-15659"
    ƴ������(180) = "Luo=-15652"

    ƴ������(181) = "Ma=-15640"
    ƴ������(182) = "Mai=-15631"
    ƴ������(183) = "Man=-15625"
    ƴ������(184) = "Mang=-15454"
    ƴ������(185) = "Mao=-15448"
    ƴ������(186) = "Me=-15436"
    ƴ������(187) = "Mei=-15435"
    ƴ������(188) = "Men=-15419"
    ƴ������(189) = "Meng=-15416"
    ƴ������(190) = "Mi=-15408"
    ƴ������(191) = "Mian=-15394"
    ƴ������(192) = "Miao=-15385"
    ƴ������(193) = "Mie=-15377"
    ƴ������(194) = "Min=-15375"
    ƴ������(195) = "Ming=-15369"
    ƴ������(196) = "Miu=-15363"
    ƴ������(197) = "Mo=-15362"
    ƴ������(198) = "Mou=-15183"
    ƴ������(199) = "Mu=-15180"

    ƴ������(200) = "Na=-15165"
    ƴ������(201) = "Nai=-15158"
    ƴ������(202) = "Nan=-15153"
    ƴ������(203) = "Nang=-15150"
    ƴ������(204) = "Nao=-15149"
    ƴ������(205) = "Ne=-15144"
    ƴ������(206) = "Nei=-15143"
    ƴ������(207) = "Nen=-15141"
    ƴ������(208) = "Neng=-15140"
    ƴ������(209) = "Ni=-15139"
    ƴ������(210) = "Nian=-15128"
    ƴ������(211) = "Niang=-15121"
    ƴ������(212) = "Niao=-15119"
    ƴ������(213) = "Nie=-15117"
    ƴ������(214) = "Nin=-15110"
    ƴ������(215) = "Ning=-15109"
    ƴ������(216) = "Niu=-14941"
    ƴ������(217) = "Nong=-14937"
    ƴ������(218) = "Nu=-14933"
    ƴ������(219) = "Nv=-14930"
    ƴ������(220) = "Nuan=-14929"
    ƴ������(221) = "Nue=-14928"
    ƴ������(222) = "Nuo=-14926"

    ƴ������(223) = "O=-14922"
    ƴ������(224) = "Ou=-14921"

    ƴ������(225) = "Pa=-14914"
    ƴ������(226) = "Pai=-14908"
    ƴ������(227) = "Pan=-14902"
    ƴ������(228) = "Pang=-14894"
    ƴ������(229) = "Pao=-14889"
    ƴ������(230) = "Pei=-14882"
    ƴ������(231) = "Pen=-14873"
    ƴ������(232) = "Peng=-14871"
    ƴ������(233) = "Pi=-14857"
    ƴ������(234) = "Pian=-14678"
    ƴ������(235) = "Piao=-14674"
    ƴ������(236) = "Pie=-14670"
    ƴ������(237) = "Pin=-14668"
    ƴ������(238) = "Ping=-14663"
    ƴ������(239) = "Po=-14654"
    ƴ������(240) = "Pu=-14645"

    ƴ������(241) = "Qi=-14630"
    ƴ������(242) = "Qia=-14594"
    ƴ������(243) = "Qian=-14429"
    ƴ������(244) = "Qiang=-14407"
    ƴ������(245) = "Qiao=-14399"
    ƴ������(246) = "Qie=-14384"
    ƴ������(247) = "Qin=-14379"
    ƴ������(248) = "Qing=-14368"
    ƴ������(249) = "Qiong=-14355"
    ƴ������(250) = "Qiu=-14353"
    ƴ������(251) = "Qu=-14345"
    ƴ������(252) = "Quan=-14170"
    ƴ������(253) = "Que=-14159"
    ƴ������(254) = "Qun=-14151"

    ƴ������(255) = "Ran=-14149"
    ƴ������(256) = "Rang=-14145"
    ƴ������(257) = "Rao=-14140"
    ƴ������(258) = "Re=-14137"
    ƴ������(259) = "Ren=-14135"
    ƴ������(260) = "Reng=-14125"
    ƴ������(261) = "Ri=-14123"
    ƴ������(262) = "Rong=-14122"
    ƴ������(263) = "Rou=-14112"
    ƴ������(264) = "Ru=-14109"
    ƴ������(265) = "Ruan=-14099"
    ƴ������(266) = "Rui=-14097"
    ƴ������(267) = "Run=-14094"
    ƴ������(268) = "Ruo=-14092"

    ƴ������(269) = "Sa=-14090"
    ƴ������(270) = "Sai=-14087"
    ƴ������(271) = "San=-14083"
    ƴ������(272) = "Sang=-13917"
    ƴ������(273) = "Sao=-13914"
    ƴ������(274) = "Se=-13910"
    ƴ������(275) = "Sen=-13907"
    ƴ������(276) = "Seng=-13906"
    ƴ������(277) = "Sha=-13905"
    ƴ������(278) = "Shai=-13896"
    ƴ������(279) = "Shan=-13894"
    ƴ������(280) = "Shang=-13878"
    ƴ������(281) = "Shao=-13870"
    ƴ������(282) = "She=-13859"
    ƴ������(283) = "Shen=-13847"
    ƴ������(284) = "Sheng=-13831"
    ƴ������(285) = "Shi=-13658"
    ƴ������(286) = "Shou=-13611"
    ƴ������(287) = "Shu=-13601"
    ƴ������(288) = "Shua=-13406"
    ƴ������(289) = "Shuai=-13404"
    ƴ������(290) = "Shuan=-13400"
    ƴ������(291) = "Shuang=-13398"
    ƴ������(292) = "Shui=-13395"
    ƴ������(293) = "Shun=-13391"
    ƴ������(294) = "Shuo=-13387"
    ƴ������(295) = "Si=-13383"
    ƴ������(296) = "Song=-13367"
    ƴ������(297) = "Sou=-13359"
    ƴ������(298) = "Su=-13356"
    ƴ������(299) = "Suan=-13343"
    ƴ������(300) = "Sui=-13340"
    ƴ������(301) = "Sun=-13329"
    ƴ������(302) = "Suo=-13326"

    ƴ������(303) = "Ta=-13318"
    ƴ������(304) = "Tai=-13147"
    ƴ������(305) = "Tan=-13138"
    ƴ������(306) = "Tang=-13120"
    ƴ������(307) = "Tao=-13107"
    ƴ������(308) = "Te=-13096"
    ƴ������(309) = "Teng=-13095"
    ƴ������(310) = "Ti=-13091"
    ƴ������(311) = "Tian=-13076"
    ƴ������(312) = "Tiao=-13068"
    ƴ������(313) = "Tie=-13063"
    ƴ������(314) = "Ting=-13060"
    ƴ������(315) = "Tong=-12888"
    ƴ������(316) = "Tou=-12875"
    ƴ������(317) = "Tu=-12871"
    ƴ������(318) = "Tuan=-12860"
    ƴ������(319) = "Tui=-12858"
    ƴ������(320) = "Tun=-12852"
    ƴ������(321) = "Tuo=-12849"

    ƴ������(322) = "Wa=-12838"
    ƴ������(323) = "Wai=-12831"
    ƴ������(324) = "Wan=-12829"
    ƴ������(325) = "Wang=-12812"
    ƴ������(326) = "Wei=-12802"
    ƴ������(327) = "Wen=-12607"
    ƴ������(328) = "Weng=-12597"
    ƴ������(329) = "Wo=-12594"
    ƴ������(330) = "Wu=-12585"

    ƴ������(331) = "Xi=-12556"
    ƴ������(332) = "Xia=-12359"
    ƴ������(333) = "Xian=-12346"
    ƴ������(334) = "Xiang=-12320"
    ƴ������(335) = "Xiao=-12300"
    ƴ������(336) = "Xie=-12120"
    ƴ������(337) = "Xin=-12099"
    ƴ������(338) = "Xing=-12089"
    ƴ������(339) = "Xiong=-12074"
    ƴ������(340) = "Xiu=-12067"
    ƴ������(341) = "Xu=-12058"
    ƴ������(342) = "Xuan=-12039"
    ƴ������(343) = "Xue=-11867"
    ƴ������(344) = "Xun=-11861"

    ƴ������(345) = "Ya=-11847"
    ƴ������(346) = "Yan=-11831"
    ƴ������(347) = "Yang=-11798"
    ƴ������(348) = "Yao=-11781"
    ƴ������(349) = "Ye=-11604"
    ƴ������(350) = "Yi=-11589"
    ƴ������(351) = "Yin=-11536"
    ƴ������(352) = "Ying=-11358"
    ƴ������(353) = "Yo=-11340"
    ƴ������(354) = "Yong=-11339"
    ƴ������(355) = "You=-11324"
    ƴ������(356) = "Yu=-11303"
    ƴ������(357) = "Yuan=-11097"
    ƴ������(358) = "Yue=-11077"
    ƴ������(359) = "Yun=-11067"

    ƴ������(360) = "Za=-11055"
    ƴ������(361) = "Zai=-11052"
    ƴ������(362) = "Zan=-11045"
    ƴ������(363) = "Zang=-11041"
    ƴ������(364) = "Zao=-11038"
    ƴ������(365) = "Ze=-11024"
    ƴ������(366) = "Zei=-11020"
    ƴ������(367) = "Zen=-11019"
    ƴ������(368) = "Zeng=-11018"
    ƴ������(369) = "Zha=-11014"
    ƴ������(370) = "Zhai=-10838"
    ƴ������(371) = "Zhan=-10832"
    ƴ������(372) = "Zhang=-10815"
    ƴ������(373) = "Zhao=-10800"
    ƴ������(374) = "Zhe=-10790"
    ƴ������(375) = "Zhen=-10780"
    ƴ������(376) = "Zheng=-10764"
    ƴ������(377) = "Zhi=-10587"
    ƴ������(378) = "Zhong=-10544"
    ƴ������(379) = "Zhou=-10533"
    ƴ������(380) = "Zhu=-10519"
    ƴ������(381) = "Zhua=-10331"
    ƴ������(382) = "Zhuai=-10329"
    ƴ������(383) = "Zhuan=-10328"
    ƴ������(384) = "Zhuang=-10322"
    ƴ������(385) = "Zhui=-10315"
    ƴ������(386) = "Zhun=-10309"
    ƴ������(387) = "Zhuo=-10307"
    ƴ������(388) = "Zi=-10296"
    ƴ������(389) = "Zong=-10281"
    ƴ������(390) = "Zou=-10274"
    ƴ������(391) = "Zu=-10270"
    ƴ������(392) = "Zuan=-10262"
    ƴ������(393) = "Zui=-10260"
    ƴ������(394) = "Zun=-10256"
    ƴ������(395) = "Zuo=-10254"
    ����ƴ�� = ""
    Dim i,������,ƴ��
    For i = 1 To Len(���ĺ���) 
        ������ = Asc(Mid(���ĺ���, i, 1))
        If ������ > 0 And ������ < 160 Then
            //����ƴ����Χ�ڻ�ԭ����
            ƴ�� = Chr(������)
        Else
            If ������ < -20319 Or ������ > -10247 Then
                //����ƴ����Χ�ڻ�ԭ����
                ƴ�� = Chr(������)
            Else
                Dim �ָ�,n,����ƴ��
                For n = UBound(ƴ������) To 0 Step -1
                    �ָ� = Split(ƴ������(n), "=")
                    If CLng(�ָ�(1)) <= ������ Then Exit For
                Next
                ƴ�� = �ָ�(0)
            End If
        End If
        ����ƴ�� = ����ƴ�� & ƴ��
    Next
    ���ĺ���תƴ�� = ����ƴ��
End Function
Function ����ַ���(λ��)
    //���ӣ�Msgbox lib.�㷨.����ַ���(16)
    Dim i,λ��,�ַ���,��ĸ
    ��ĸ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    �ַ���=""
    For i=0 To λ�� - 1
        Randomize
        λ�� = Int((Len(��ĸ) * Rnd) + 1)
        �ַ��� = �ַ��� & Mid(��ĸ,λ��,1)
    Next
    ����ַ��� = �ַ���
End Function 
Function ������ִ�(λ��)
    //���ӣ�Msgbox lib.�㷨.������ִ�(16)
    Dim i,λ��,����,���ִ�
    ����="0123456789"
    ���ִ�=""
    For i=0 To λ�� - 1
        Randomize
        λ�� = Int((Len(����) * Rnd) + 1)
        ���ִ� = ���ִ� & Mid(����,λ��,1)
    Next
    ������ִ� = ���ִ�
End Function 
Function ���ȡ����()
    //���ӣ�Msgbox lib.�㷨.���ȡ����()
    Dim a,b,c,nei,zhu
    Randomize
    a = CInt((102) * Rnd)
    b = CInt((85) * Rnd)
    c = CInt((59) * Rnd)
    nei = ""
    Select Case a
    Case 1
        zhu = "��"
    Case 2
        zhu = "��"
    Case 3
        zhu = "��"
    Case 4
        zhu = "��"
    Case 5
        zhu = "��"
    Case 6
        zhu = "л"
    Case 7
        zhu = "��"
    Case 8
        zhu = "Ԭ"
    Case 9
        zhu = "��"
    Case 10
        zhu = "��"
    Case 11
        zhu = "��"
    Case 12
        zhu = "��"
    Case 13
        zhu = "κ"
    Case 14
        zhu = "Ѧ"
    Case 15
        zhu = "��"
    Case 16
        zhu = "��"
    Case 17
        zhu = "��"
    Case 18
        zhu = "��"
    Case 19
        zhu = "��"
    Case 20
        zhu = "Ҧ"
    Case 21
        zhu = "��"
    Case 22
        zhu = "��"
    Case 23
        zhu = "��"
    Case 24
        zhu = "�ؽ�"
    Case 25
        zhu = "��"
    Case 26
        zhu = "��"
    Case 27
        zhu = "��"
    Case 28
        zhu = "��"
    Case 29
        zhu = "��"
    Case 30
        zhu = "��"
    Case 31
        zhu = "��"
    Case 32
        zhu = "�ĺ�"
    Case 33
        zhu = "���"
    Case 34
        zhu = "�Ϲ�"
    Case 35
        zhu = "ŷ��"
    Case 36
        zhu = "ξ��"
    Case 37
        zhu = "����"
    Case 38
        zhu = "��"
    Case 39
        zhu = "ī"
    Case 40
        zhu = "��"
    Case 41
        zhu = "Ϳ"
    Case 42
        zhu = "��"
    Case 43
        zhu = "��"
    Case 44
        zhu = "��"
    Case 45
        zhu = "��"
    Case 46
        zhu = "��"
    Case 47
        zhu = "��"
    Case 48
        zhu = "ׯ"
    Case 49
        zhu = "ׯ"
    Case 50
        zhu = "��"
    Case 51
        zhu = "˾��"
    Case 52
        zhu = "��"
    Case 53
        zhu = "��"
    Case 54
        zhu = "��"
    Case 55
        zhu = "��"
    Case 56
        zhu = "��"
    Case 57
        zhu = "��"
    Case 58
        zhu = "��"
    Case 59
        zhu = "��"
    Case 60
        zhu = "��"
    Case 61
        zhu = "��"
    Case 62
        zhu = "��"
    Case 63
        zhu = "��"
    Case 64
        zhu = "��"
    Case 65
        zhu = "��"
    Case 66
        zhu = "��"
    Case 67
        zhu = "��"
    Case 68
        zhu = "��"
    Case 69
        zhu = "��"
    Case 70
        zhu = "��"
    Case 71
        zhu = "��"
    Case 72
        zhu = "��"
    Case 73
        zhu = "��"
    Case 74
        zhu = "��"
    Case 75
        zhu = "��"
    Case 76
        zhu = "�"
    Case 77
        zhu = "��"
    Case 78
        zhu = "��"
    Case 79
        zhu = "��"
    Case 80
        zhu = "��"
    Case 81
        zhu = "��"
    Case 82
        zhu = "��"
    Case 83
        zhu = "��"
    Case 84
        zhu = "��"
    Case 85
        zhu = "��"
    Case 86
        zhu = "��"
    Case 87
        zhu = "��"
    Case 88
        zhu = "��"
    Case 89
        zhu = "��"
    Case 90
        zhu = "��"
    Case 91
        zhu = "��"
    Case 92
        zhu = "ۢ"
    Case 93
        zhu = "̷"
    Case 94
        zhu = "��"
    Case 95
        zhu = "��"
    Case 96
        zhu = "��"
    Case 97
        zhu = "Ф"
    Case 98
        zhu = "��"
    Case 99
        zhu = "��"
    Case 100
        zhu = "Ԭ"
    Case 101
        zhu = "��"
    Case 102
        zhu = "ͯ"
    End Select
    nei = nei & zhu
    Select Case b
    Case 1
        zhu = "��"
    Case 2
        zhu = "��"
    Case 3
        zhu = "��"
    Case 4
        zhu = "��"
    Case 5
        zhu = "ï"
    Case 6
        zhu = "��"
    Case 7
        zhu = "ٻ"
    Case 8
        zhu = "��"
    Case 9
        zhu = "ϼ"
    Case 10
        zhu = "ݬ"
    Case 11
        zhu = "��"
    Case 12
        zhu = "��"
    Case 13
        zhu = "��"
    Case 14
        zhu = "��"
    Case 15
        zhu = "Ī"
    Case 16
        zhu = "��"
    Case 17
        zhu = "��"
    Case 18
        zhu = "ʫ"
    Case 19
        zhu = "��"
    Case 20
        zhu = "��"
    Case 21
        zhu = "��"
    Case 22
        zhu = "ѩ"
    Case 23
        zhu = "��"
    Case 24
        zhu = "��"
    Case 25
        zhu = "ɭ"
    Case 26
        zhu = "��"
    Case 27
        zhu = "��"
    Case 28
        zhu = "��"
    Case 29
        zhu = "��"
    Case 30
        zhu = "��"
    Case 31
        zhu = "˫"
    Case 32
        zhu = "��"
    Case 33
        zhu = "��"
    Case 34
        zhu = "��"
    Case 35
        zhu = "��"
    Case 36
        zhu = "��"
    Case 37
        zhu = "��"
    Case 38
        zhu = "��"
    Case 39
        zhu = "��"
    Case 40
        zhu = "Ȫ"
    Case 41
        zhu = "��"
    Case 42
        zhu = "��"
    Case 43
        zhu = "��"
    Case 44
        zhu = "��"
    Case 45
        zhu = "��"
    Case 46
        zhu = "Ȼ"
    Case 47
        zhu = "��"
    Case 48
        zhu = "��"
    Case 49
        zhu = "��"
    Case 50
        zhu = "��"
    Case 51
        zhu = "��"
    Case 52
        zhu = "־"
    Case 53
        zhu = "��"
    Case 54
        zhu = "��"
    Case 55
        zhu = "��"
    Case 56
        zhu = "��"
    Case 57
        zhu = "��"
    Case 58
        zhu = "��"
    Case 59
        zhu = "��"
    Case 60
        zhu = "��"
    Case 61
        zhu = "��"
    Case 62
        zhu = "Է"
    Case 63
        zhu = "��"
    Case 64
        zhu = "��"
    Case 65
        zhu = "��"
    Case 66
        zhu = "��"
    Case 67
        zhu = "��"
    Case 68
        zhu = "��"
    Case 69
        zhu = "�"
    Case 70
        zhu = "Ԩ"
    Case 71
        zhu = "�"
    Case 72
        zhu = "�"
    Case 73
        zhu = "��"
    Case 74
        zhu = "��"
    Case 75
        zhu = "�"
    Case 76
        zhu = "��"
    Case 77
        zhu = "��"
    Case 78
        zhu = "��"
    Case 79
        zhu = "��"
    Case 80
        zhu = "��"
    Case 81
        zhu = "��"
    Case 82
        zhu = "��"
    Case 83
        zhu = "��"
    Case 84
        zhu = "��"
    Case 85
        zhu = "��"
    End Select
    nei = nei & zhu
    //��������
    Select Case c
    Case 1
        zhu = "��"
    Case 2
        zhu = "��"
    Case 3
        zhu = "��"
    Case 4
        zhu = "��"
    Case 5
        zhu = "��"
    Case 6
        zhu = "��"
    Case 7
        zhu = "��"
    Case 8
        zhu = "ֲ"
    Case 9
        zhu = "��"
    Case 10
        zhu = "��"
    Case 11
        zhu = "��"
    Case 12
        zhu = "̽"
    Case 13
        zhu = "��"
    Case 14
        zhu = "��"
    Case 15
        zhu = "��"
    Case 16
        zhu = "��"
    Case 17
        zhu = "��"
    Case 18
        zhu = "��"
    Case 19
        zhu = "��"
    Case 20
        zhu = "��"
    Case 21
        zhu = "��"
    Case 22
        zhu = "��"
    Case 23
        zhu = "��"
    Case 24
        zhu = "�"
    Case 25
        zhu = "��"
    Case 26
        zhu = "��"
    Case 27
        zhu = "ů"
    Case 28
        zhu = "�"
    Case 29
        zhu = "�"
    Case 30
        zhu = "��"
    Case 31
        zhu = "��"
    Case 32
        zhu = "��"
    Case 33
        zhu = "��"
    Case 34
        zhu = "��"
    Case 35
        zhu = "��"
    Case 36
        zhu = "��"
    Case 37
        zhu = "��"
    Case 38
        zhu = "��"
    Case 39
        zhu = "��"
    Case 40
        zhu = "��"
    Case 41
        zhu = "��"
    Case 42
        zhu = "��"
    Case 43
        zhu = "��"
    Case 44
        zhu = "��"
    Case 45
        zhu = "��"
    Case 46
        zhu = "��"
    Case 47
        zhu = "��"
    Case 48
        zhu = "��"
    Case 49
        zhu = "��"
    Case 50
        zhu = "��"
    Case 51
        zhu = "��"
    Case 52
        zhu = "��"
    Case 53
        zhu = "�"
    Case 54
        zhu = "�"
    Case 55
        zhu = "÷"
    Case 56
        zhu = "��"
    Case 57
        zhu = "��"
    Case 58
        zhu = "ϼ"
    Case 59
        zhu = "��"
    End Select
    ���ȡ���� = nei & zhu
End Function
Function �õ��ַ�������ĸ������(�ַ���)
    //���ӣ�MsgBox lib.�㷨.�õ��ַ�������ĸ������("[email=abc@#$%de]abc@#$%de[/email]")
    Dim TQstring  
    TQstring = "Dim regEx, Matches, shuliang" & vbCrLf                    //�������
    TQstring = TQstring & "Set regEx = New RegExp" & vbCrLf               //�����������ʽ
    TQstring = TQstring & "regEx.Pattern = ""([a-z]{1})""" & vbCrLf       //���ù���ģʽ
    TQstring = TQstring & "regEx.IgnoreCase = true" & vbCrLf              //�����Ƿ������ַ���Сд
    TQstring = TQstring & "regEx.Global = True" & vbCrLf                  //����ȫ�ֿ�����
    TQstring = TQstring & "Set Matches = regEx.Execute(""" & �ַ��� & """)" & vbCrLf   //ִ������   
    TQstring = TQstring & "shuliang = Matches.count"
    Execute TQstring 
    �õ��ַ�������ĸ������ = shuliang  
End Function  
Function ʮ������תʮ����(ʮ�������ַ���)
    //���ӣ�Msgbox lib.�㷨.ʮ������תʮ����("FFFFFF")
    Dim D,H,i,Ia
    D = 0
    H = UCase(ʮ�������ַ���)
    For i = 1 To Len(H)
        Ia = Asc(Mid(H, i, 1)) - 48
        If Ia > 9 Then Ia = Ia - 7
        D = D * 16 + Ia
    Next
    ʮ������תʮ���� = D
End Function
Sub �˷���������()
    //���ӣ�Call lib.�㷨.�˷���������()
    Dim c,d 
    Dim str,s
    For c = 1 To 9 
        For d = 1 To c
            s = d & "��" & c & "=" & c * d 
            s = s & Space(6-len(s))
            str = str & s & " " 
        Next 
        str = str & vbCrlf  
    Next
    MsgBox str,0,"�˷���������" 
End Sub 
Function ϴ��(�ַ�������)
    //˵�������Դ���һ������˳��
    //���ӣ�MsgBox lib.�㷨.ϴ��("123��456")
    Dim ���,����,i, j, temp
    ����=Len(�ַ�������)
    ReDim tt(����)
    ��� = ""
    For i = 1 To ���� 
        tt(i) = Mid(�ַ�������,i,1)
    Next
    Randomize
    For j = 1 To ����
        i = Int(���� * Rnd + 1)
        temp=tt(i)        
        tt(i)=tt(j)
        tt(j)=temp 
    Next
    ϴ�� = Join(tt,"")
End Function
Function �ж��Ƿ���һ��ֱ����(���x����,���y����,�յ�x����,�յ�y����,�жϵ�x����,�жϵ�y����)
    //���ӣ�MsgBox CBool(lib.�㷨.�ж��Ƿ���һ��ֱ����(0,3,2,5,4,7))
    //���㹫ʽ��y=k*x+b 
    Dim k,b,y   
    �ж��Ƿ���һ��ֱ����=False
    //�жϳ����Ƿ�Ϊ0
    If �յ�x���� - ���x���� = 0 or �յ�y���� - ���y���� = 0 then
        //ֻ���ж����� ���� ���� ����
        If (�жϵ�y���� >= ���y���� and �жϵ�y���� <= �յ�y����) and (�жϵ�x���� >= ���x���� and �жϵ�x���� <= �յ�x����) then
            �ж��Ƿ���һ��ֱ����=True 
        End if
        Exit Function 
    End If
    k = abs(�յ�y����-���y����) / abs(�յ�x����-���x����) 
    b = ���y���� - k * ���x����
    y = k * �жϵ�x���� + b
    //�������С���㣬���Լӷ�Χ�ж�
    If y>�жϵ�y����-1 and y<�жϵ�y����+1 Then
        �ж��Ƿ���һ��ֱ����=True
    End If
End Function
Function �Ƕȼ���(���ĵ�x����, ���ĵ�y����, �ƶ���x����, �ƶ���y����)
    Dim x, y, a, b
    If �ƶ���x����=���ĵ�x���� Then
        If �ƶ���y����>���ĵ�y���� Then
            //��
            �Ƕȼ��� = 180
        Else
            //��
            �Ƕȼ��� = 0
        End If
    ElseIf �ƶ���y����=���ĵ�y���� Then
        If �ƶ���x����>���ĵ�x���� Then
            //��
            �Ƕȼ��� = 90
        Else
            //��
            �Ƕȼ��� = 270
        End If
    Else 
        x = abs(�ƶ���y���� - ���ĵ�y����)
        y = abs(�ƶ���x���� - ���ĵ�x����)
        If x > 0 Then 
            //1����ԼΪ57.3
            a = Atn(y / x)
            If �ƶ���x����>���ĵ�x���� and �ƶ���y����>���ĵ�y���� Then
                //�K
                b = 180
                �Ƕȼ��� = b - fix(a * 57.3)
            ElseIf �ƶ���x����>���ĵ�x���� and �ƶ���y����<���ĵ�y���� Then
                //�J
                b = 0
                �Ƕȼ��� = fix(a * 57.3) + b
            ElseIf �ƶ���x����<���ĵ�x���� and �ƶ���y����<���ĵ�y���� Then
                //�I
                b = 360
                �Ƕȼ��� = b - fix(a * 57.3)
            ElseIf �ƶ���x����<���ĵ�x���� and �ƶ���y����>���ĵ�y���� Then
                //�L
                b = 180
                �Ƕȼ��� = fix(a * 57.3) + b
            End If
        End If
    End If
End Function
//�޸���:Mr.L



//������һֻ��
//���ڣ�2009.12.22
//�޸ģ�2011.11.30




