
import 'package:flutter/material.dart';

void main() => runApp(const CyrusApp());

const navy = Color(0xFF050816);
const panel = Color(0xFF0B1225);
const cyan = Color(0xFF21D9FF);
const purple = Color(0xFFAD45FF);
const green = Color(0xFF38E879);

class CyrusApp extends StatelessWidget {
  const CyrusApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'CYRUS',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: const ColorScheme.dark(primary: cyan, surface: panel),
      fontFamily: 'Roboto',
      useMaterial3: true,
    ),
    home: const MainShell(),
  );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState()=>_MainShellState();
}
class _MainShellState extends State<MainShell> {
  int tab=0;
  bool demoState=false;
  bool notifications=true;
  bool compact=false;
  final List<String> savedItems=['Tehran • نمونه','Frankfurt • نمونه','Tokyo • نمونه'];
  final List<IconData> navIcons=[Icons.home_rounded,Icons.grid_view_rounded,Icons.insights_rounded,Icons.settings_rounded];
  final List<String> navTitles=['خانه','فهرست','آمار','تنظیمات'];

  void toast(String msg)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(msg),backgroundColor:const Color(0xFF18243A)));
  @override
  Widget build(BuildContext context)=>Directionality(
    textDirection:TextDirection.rtl,
    child:Scaffold(
      body:SafeArea(child:Stack(children:[
        const Positioned.fill(child:BackgroundArt()),
        Column(children:[
          header(),
          Expanded(child:IndexedStack(index:tab,children:[home(),listPage(),statsPage(),settingsPage()])),
          navBar(),
        ]),
      ])),
    ),
  );

  Widget header()=>Padding(
    padding:const EdgeInsets.fromLTRB(16,8,16,2),
    child:Row(children:[
      IconButton(onPressed:()=>setState(()=>tab=3),icon:const Icon(Icons.menu_rounded,color:cyan,size:28)),
      const Spacer(),
      Column(children:[
        const Text('CYRUS',style:TextStyle(fontSize:32,fontWeight:FontWeight.w900,letterSpacing:2.8,fontStyle:FontStyle.italic)),
        Text('YOUR DIGITAL SPACE',style:TextStyle(color:cyan.withOpacity(.75),fontSize:9,letterSpacing:2.2,fontWeight:FontWeight.bold)),
      ]),
      const Spacer(),
      Container(width:42,height:42,decoration:BoxDecoration(borderRadius:BorderRadius.circular(14),border:Border.all(color:purple.withOpacity(.6)),color:Colors.white.withOpacity(.04)),child:IconButton(padding:EdgeInsets.zero,onPressed:()=>toast('تنظیمات ظاهر در این نمونه'),icon:const Icon(Icons.palette_outlined,color:Colors.white70,size:21))),
    ]),
  );

  Widget home()=>SingleChildScrollView(padding:const EdgeInsets.fromLTRB(16,10,16,18),child:Column(children:[
    statusPill(),
    const SizedBox(height:15),
    mainButton(),
    const SizedBox(height:18),
    selectedItem(),
    const SizedBox(height:12),
    Row(children:[Expanded(child:metric(Icons.bolt_rounded,'پینگ','—','بدون داده زنده',purple)),const SizedBox(width:10),Expanded(child:metric(Icons.download_rounded,'دریافت','—','نمایش نمونه',cyan))]),
    const SizedBox(height:10),
    Row(children:[Expanded(child:metric(Icons.upload_rounded,'ارسال','—','نمایش نمونه',purple)),const SizedBox(width:10),Expanded(child:metric(Icons.timer_outlined,'مدت','00:00','حالت نمایشی',cyan))]),
    const SizedBox(height:14),
    noteCard('نسخه رابط کاربری','این پروژه نمونه طراحی مستقل است. وضعیت و اعداد نمایش‌داده‌شده واقعی یا متصل به شبکه نیستند.',Icons.info_outline),
  ]));

  Widget statusPill()=>Container(padding:const EdgeInsets.symmetric(horizontal:18,vertical:10),decoration:BoxDecoration(color:Colors.black.withOpacity(.32),borderRadius:BorderRadius.circular(30),border:Border.all(color:demoState?green.withOpacity(.6):cyan.withOpacity(.4))),child:Row(mainAxisSize:MainAxisSize.min,children:[Container(width:9,height:9,decoration:BoxDecoration(color:demoState?green:Colors.orangeAccent,shape:BoxShape.circle,boxShadow:[BoxShadow(color:(demoState?green:Colors.orangeAccent).withOpacity(.45),blurRadius:8)])),const SizedBox(width:9),Text(demoState?'حالت نمایشی روشن':'آماده به کار',style:TextStyle(color:demoState?green:Colors.white70,fontWeight:FontWeight.w700))]));

  Widget mainButton()=>GestureDetector(onTap:()=>setState(()=>demoState=!demoState),child:Container(width:280,height:280,decoration:BoxDecoration(shape:BoxShape.circle,gradient:RadialGradient(colors:[cyan.withOpacity(.12),purple.withOpacity(.08),navy]),boxShadow:[BoxShadow(color:cyan.withOpacity(.12),blurRadius:34,spreadRadius:2)]),child:Stack(alignment:Alignment.center,children:[
    Container(width:270,height:270,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:cyan.withOpacity(.18),width:1))),
    Container(width:244,height:244,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:purple.withOpacity(.52),width:2),boxShadow:[BoxShadow(color:purple.withOpacity(.15),blurRadius:16)])),
    Container(width:215,height:215,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:cyan.withOpacity(.8),width:2),color:Colors.black.withOpacity(.2))),
    Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(demoState?Icons.check_circle_outline:Icons.shield_outlined,color:cyan,size:53),const SizedBox(height:8),Text(demoState?'روشن':'شروع',style:const TextStyle(fontSize:28,fontWeight:FontWeight.bold)),const SizedBox(height:4),Text('فقط تعامل نمایشی',style:TextStyle(color:Colors.white.withOpacity(.55),fontSize:12))])
  ])));

  Widget selectedItem()=>InkWell(onTap:()=>setState(()=>tab=1),borderRadius:BorderRadius.circular(20),child:Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),gradient:const LinearGradient(colors:[Color(0xFF151431),Color(0xFF07182A)]),border:Border.all(color:cyan.withOpacity(.45))),child:Row(children:[Container(width:48,height:48,decoration:BoxDecoration(color:cyan.withOpacity(.12),borderRadius:BorderRadius.circular(14)),child:const Icon(Icons.public_rounded,color:cyan,size:27)),const SizedBox(width:12),const Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('مورد انتخاب‌شده',style:TextStyle(fontWeight:FontWeight.bold,fontSize:16)),SizedBox(height:4),Text('برای مشاهده فهرست، لمس کنید',style:TextStyle(color:Colors.white54,fontSize:11))])),const Icon(Icons.chevron_left_rounded,color:cyan,size:28)])));

  Widget metric(IconData icon,String title,String value,String caption,Color color)=>Container(height:116,padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(18),border:Border.all(color:color.withOpacity(.3))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Icon(icon,color:color,size:21),const SizedBox(width:7),Text(title,style:const TextStyle(color:Colors.white70))]),const Spacer(),Text(value,style:TextStyle(color:color,fontSize:22,fontWeight:FontWeight.bold)),Text(caption,style:const TextStyle(color:Colors.white38,fontSize:10))]));

  Widget listPage()=>SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    pageTitle('فهرست','آیتم‌های نمونه و مدیریت محلی'),
    const SizedBox(height:14),
    ...savedItems.asMap().entries.map((e)=>Padding(padding:const EdgeInsets.only(bottom:10),child:Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white12)),child:Row(children:[const Icon(Icons.folder_outlined,color:cyan,size:24),const SizedBox(width:10),Expanded(child:Text(e.value,style:const TextStyle(fontWeight:FontWeight.w600))),IconButton(onPressed:()=>setState(()=>savedItems.removeAt(e.key)),icon:const Icon(Icons.delete_outline,color:Colors.white54))])))),
    const SizedBox(height:8),
    OutlinedButton.icon(onPressed:()=>showDialog(context:context,builder:(ctx){final c=TextEditingController();return AlertDialog(backgroundColor:panel,title:const Text('افزودن مورد نمونه'),content:TextField(controller:c,decoration:const InputDecoration(hintText:'عنوان')) ,actions:[TextButton(onPressed:()=>Navigator.pop(ctx),child:const Text('لغو')),TextButton(onPressed:(){if(c.text.trim().isNotEmpty)setState(()=>savedItems.add(c.text.trim()));Navigator.pop(ctx);},child:const Text('افزودن'))]);}),icon:const Icon(Icons.add),label:const Text('افزودن مورد')),
    const SizedBox(height:12),noteCard('توضیح','این فهرست صرفاً برای نمایش رابط و قابلیت‌های عمومی مدیریت است.',Icons.info_outline),
  ]));

  Widget statsPage()=>SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(children:[
    pageTitle('آمار','نمایش ساختار داشبورد'),
    const SizedBox(height:14),
    Row(children:[Expanded(child:metric(Icons.timeline,'فعالیت','—','داده‌ای موجود نیست',cyan)),const SizedBox(width:10),Expanded(child:metric(Icons.storage_rounded,'داده','0','نمونه',purple))]),
    const SizedBox(height:12),
    Container(height:210,padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(20),border:Border.all(color:cyan.withOpacity(.25))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('نمودار فعالیت',style:TextStyle(fontWeight:FontWeight.bold)),const Spacer(),Expanded(child:CustomPaint(painter:ChartPainter(),child:const SizedBox.expand())),const SizedBox(height:10),const Center(child:Text('اطلاعاتی برای رسم نمودار وجود ندارد',style:TextStyle(color:Colors.white38,fontSize:11)))])),
    const SizedBox(height:12),noteCard('آمار زنده','این صفحه در نسخه نمایشی هیچ داده واقعی جمع‌آوری نمی‌کند.',Icons.analytics_outlined),
  ]));

  Widget settingsPage()=>ListView(padding:const EdgeInsets.all(16),children:[
    pageTitle('تنظیمات','شخصی‌سازی تجربه برنامه'),
    const SizedBox(height:14),
    settingsTile(Icons.notifications_none,'اعلان‌ها','کنترل اعلان‌های برنامه',notifications,(v)=>setState(()=>notifications=v)),
    settingsTile(Icons.view_compact_outlined,'نمای فشرده','کاهش فاصله کارت‌ها',compact,(v)=>setState(()=>compact=v)),
    const SizedBox(height:10),
    noteCard('درباره CYRUS','یک رابط مستقل با طراحی نئونی و ساختار چندصفحه‌ای. این نسخه، نمونه UI است.',Icons.info_outline),
    const SizedBox(height:12),
    Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(16)),child:const Row(children:[Icon(Icons.code,color:cyan),SizedBox(width:10),Expanded(child:Text('نسخه رابط 2.0 • Flutter UI Prototype',style:TextStyle(color:Colors.white70,fontSize:12)))])),
  ]);

  Widget settingsTile(IconData icon,String title,String subtitle,bool value,ValueChanged<bool> onChanged)=>Container(margin:const EdgeInsets.only(bottom:10),padding:const EdgeInsets.symmetric(horizontal:14,vertical:9),decoration:BoxDecoration(color:panel,borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white10)),child:Row(children:[Icon(icon,color:cyan),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w600)),Text(subtitle,style:const TextStyle(color:Colors.white45,fontSize:11))])),Switch(value:value,onChanged:onChanged,activeColor:cyan)]));

  Widget pageTitle(String title,String subtitle)=>Align(alignment:Alignment.centerRight,child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontSize:24,fontWeight:FontWeight.bold)),Text(subtitle,style:const TextStyle(color:Colors.white54,fontSize:12))]));
  Widget noteCard(String title,String text,IconData icon)=>Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:Colors.white.withOpacity(.025),borderRadius:BorderRadius.circular(16),border:Border.all(color:Colors.white12)),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:cyan,size:20),const SizedBox(width:10),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:4),Text(text,style:const TextStyle(color:Colors.white54,fontSize:11,height:1.5))]))]));

  Widget navBar()=>Container(margin:const EdgeInsets.fromLTRB(12,4,12,8),padding:const EdgeInsets.symmetric(vertical:10),decoration:BoxDecoration(color:const Color(0xFF080D1B),borderRadius:BorderRadius.circular(22),border:Border.all(color:purple.withOpacity(.5)),boxShadow:[BoxShadow(color:cyan.withOpacity(.08),blurRadius:15)]),child:Row(children:List.generate(4,(i)=>Expanded(child:InkWell(onTap:()=>setState(()=>tab=i),child:Column(mainAxisSize:MainAxisSize.min,children:[Icon(navIcons[i],color:tab==i?cyan:Colors.white38,size:25),const SizedBox(height:4),Text(navTitles[i],style:TextStyle(fontSize:11,color:tab==i?cyan:Colors.white54)),if(tab==i)Container(width:24,height:3,margin:const EdgeInsets.only(top:4),decoration:BoxDecoration(color:cyan,borderRadius:BorderRadius.circular(3))]))))));
}

class BackgroundArt extends StatelessWidget {
 const BackgroundArt({super.key});
 @override Widget build(BuildContext context)=>CustomPaint(painter:BackgroundPainter(),child:const SizedBox.expand());
}
class BackgroundPainter extends CustomPainter {
 @override void paint(Canvas canvas,Size size){
  final rect=Offset.zero&size;
  final paint=Paint()..shader=RadialGradient(center:const Alignment(0,-.2),radius:1.1,colors:[const Color(0xFF14265B).withOpacity(.42),navy]).createShader(rect);
  canvas.drawRect(rect,paint);
  final grid=Paint()..color=cyan.withOpacity(.025)..strokeWidth=.6;
  for(var i=0;i<18;i++){final y=size.height*.16+i*28;canvas.drawLine(Offset(0,y),Offset(size.width,y),grid);}
  final glow=Paint()..color=purple.withOpacity(.08)..maskFilter=const MaskFilter.blur(BlurStyle.normal,42);
  canvas.drawCircle(Offset(size.width*.8,size.height*.55),size.width*.3,glow);
 }
 @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
class ChartPainter extends CustomPainter {
 @override void paint(Canvas canvas,Size size){
  final grid=Paint()..color=Colors.white.withOpacity(.08)..strokeWidth=1;
  for(int i=1;i<5;i++){final y=size.height*i/5;canvas.drawLine(Offset(0,y),Offset(size.width,y),grid);}
  final path=Path()..moveTo(0,size.height*.8)..cubicTo(size.width*.15,size.height*.7,size.width*.2,size.height*.85,size.width*.34,size.height*.58)..cubicTo(size.width*.48,size.height*.3,size.width*.58,size.height*.7,size.width*.7,size.height*.42)..cubicTo(size.width*.82,size.height*.25,size.width*.87,size.height*.5,size.width,size.height*.22);
  final line=Paint()..color=cyan.withOpacity(.65)..style=PaintingStyle.stroke..strokeWidth=2;
  canvas.drawPath(path,line);
 }
 @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
