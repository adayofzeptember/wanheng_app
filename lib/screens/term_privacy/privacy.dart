import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  TextStyle head = TextStyle(fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: AppColor.title),
        elevation: 0,
        backgroundColor: AppColor.mainColor,
        title: Text(
          "นโยบายความเป็นส่วนตัว",
          style: TextStyle(color: AppColor.title),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('นโยบายความเป็นส่วนตัวสำหรับลูกค้า', style: head),
              Text('''
บริษัท คอมพัฒนา จำกัด ให้ความสำคัญกับการคุ้มครองข้อมูลส่วนบุคคลของคุณ โดยนโยบายความเป็นส่วนตัวฉบับนี้ได้อธิบายแนวปฏิบัติเกี่ยวกับการเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคล รวมถึงสิทธิต่าง ๆ ของเจ้าของข้อมูลส่วนบุคคล ตามกฎหมายคุ้มครองข้อมูลส่วนบุคคล
'''),
              Text('การเก็บรวบรวมข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะเก็บรวบรวมข้อมูลส่วนบุคคลที่ได้รับโดยตรงจากคุณผ่านช่องทาง ดังต่อไปนี้
● การสมัครสมาชิก
● โทรศัพท์
● อีเมล
● Facebook Login
● Google Login
'''),
              Text('ประเภทข้อมูลส่วนบุคคลที่เก็บรวบรวม', style: head),
              Text('''
ประเภทข้อมูลส่วนบุคคลที่เก็บรวบรวม
● ข้อมูลส่วนบุคคล เช่น ชื่อ นามสกุล อายุ วันเดือนปีเกิด สัญชาติ เลขประจำตัวประชาชน หนังสือเดินทาง เป็นต้น
● ข้อมูลการติดต่อ เช่น ที่อยู่ หมายเลขโทรศัพท์ อีเมล เป็นต้น
● ข้อมูลบัญชี เช่น บัญชีผู้ใช้งาน ประวัติการใช้งาน เป็นต้น
● หลักฐานแสดงตัวตน เช่น สำเนาบัตรประจำตัวประชาชน สำเนาหนังสือเดินทาง เป็นต้น
● ข้อมูลการทำธุรกรรมและการเงิน เช่น ประวัติการสั่งซื้อ รายละเอียดบัตรเครดิต บัญชีธนาคาร เป็นต้น
● ข้อมูลทางเทคนิค เช่น IP address, Cookie ID, ประวัติการใช้งานเว็บไซต์ (Activity Log) เป็นต้น
● ข้อมูลอื่น ๆ เช่น รูปภาพ ภาพเคลื่อนไหว และข้อมูลอื่นใดที่ถือว่าเป็นข้อมูลส่วนบุคคลตามกฎหมายคุ้มครองข้อมูลส่วนบุคคล
'''),
              Text('ผู้เยาว์', style: head),
              Text('''
หากคุณมีอายุต่ำกว่า 20 ปีหรือมีข้อจำกัดความสามารถตามกฎหมาย เราอาจเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณ เราอาจจำเป็นต้องให้พ่อแม่หรือผู้ปกครองของคุณให้ความยินยอมหรือที่กฎหมายอนุญาตให้ทำได้ หากเราทราบว่ามีการเก็บรวบรวมข้อมูลส่วนบุคคลจากผู้เยาว์โดยไม่ได้รับความยินยอมจากพ่อแม่หรือผู้ปกครอง เราจะดำเนินการลบข้อมูลนั้นออกจากเซิร์ฟเวอร์ของเรา
'''),
              Text('วิธีการเก็บรักษาข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะเก็บรักษาข้อมูลส่วนบุคคลของคุณในรูปแบบเอกสารและรูปแบบอิเล็กทรอนิกส์
เราเก็บรักษาข้อมูลส่วนบุคคลของคุณ ดังต่อไปนี้
● ผู้ให้บริการเซิร์ฟเวอร์ในต่างประเทศ
'''),
              Text('การประมวลผลข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณเพื่อวัตถุประสงค์ดังต่อไปนี้
● เพื่อสร้างและจัดการบัญชีผู้ใช้งาน
● เพื่อจัดส่งสินค้าหรือบริการ
● เพื่อปรับปรุงสินค้า บริการ หรือประสบการณ์การใช้งาน
● เพื่อการบริหารจัดการภายในบริษัท
● เพื่อการตลาดและการส่งเสริมการขาย
● เพื่อการบริการหลังการขาย
● เพื่อรวบรวมข้อเสนอแนะ
● เพื่อชำระค่าสินค้าหรือบริการ
● เพื่อปฏิบัติตามข้อตกลงและเงื่อนไข (Terms and Conditions)
● เพื่อปฏิบัติตามกฎหมายและกฎระเบียบของหน่วยงานราชการ
'''),
              Text('วิธีการเก็บรักษาข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะเก็บรักษาข้อมูลส่วนบุคคลของคุณในรูปแบบเอกสารและรูปแบบอิเล็กทรอนิกส์
เราเก็บรักษาข้อมูลส่วนบุคคลของคุณ ดังต่อไปนี้
● ผู้ให้บริการเซิร์ฟเวอร์ในต่างประเทศ
'''),
              Text('การเปิดเผยข้อมูลส่วนบุคคล', style: head),
              Text('''
เราอาจเปิดเผยข้อมูลส่วนบุคคลของคุณให้แก่ผู้อื่นภายใต้ความยินยอมของคุณหรือที่กฎหมายอนุญาตให้เปิดเผยได้ ดังต่อไปนี้
● การบริหารจัดการภายในองค์กร
เราอาจเปิดเผยข้อมูลส่วนบุคคลของคุณภายในบริษัทเท่าที่จำเป็นเพื่อปรับปรุงและพัฒนาสินค้าหรือบริการของเรา เราอาจรวบรวมข้อมูลภายในสำหรับสินค้าหรือบริการต่าง ๆ ภายใต้นโยบายนี้เพื่อประโยชน์ของคุณและผู้อื่นมากขึ้น
● ผู้ให้บริการ
เราอาจเปิดเผยข้อมูลส่วนบุคคลของคุณบางอย่างให้กับผู้ให้บริการของเราเท่าที่จำเป็นเพื่อดำเนินงานในด้านต่าง ๆ เช่น การชำระเงิน การตลาด การพัฒนาสินค้าหรือบริการ เป็นต้น ทั้งนี้ ผู้ให้บริการมีนโยบายความเป็นส่วนตัวของตนเอง
● พันธมิตรทางธุรกิจ
เราอาจเปิดเผยข้อมูลบางอย่างกับพันธมิตรทางธุรกิจเพื่อติดต่อและประสานงานในการให้บริการสินค้าหรือบริการ และให้ข้อมูลเท่าที่จำเป็นเกี่ยวกับความพร้อมใช้งานของสินค้าหรือบริการ
● การบังคับใช้กฎหมาย
ในกรณีที่มีกฎหมายหรือหน่วยงานราชการร้องขอ เราจะเปิดเผยข้อมูลส่วนบุคคลของคุณเท่าที่จำเป็นให้แก่หน่วยงานราชการ เช่น ศาล หน่วยงานราชการ เป็นต้น
● การโอนข้อมูลส่วนบุคคลไปต่างประเทศ
เราอาจเปิดเผยหรือโอนข้อมูลส่วนบุคคลของคุณไปยังบุคคล องค์กร หรือเซิร์ฟเวอร์ (Server) ที่ตั้งอยู่ในต่างประเทศ โดยเราจะดำเนินการตามมาตรการต่าง ๆ เพื่อให้มั่นใจว่าการโอนข้อมูลส่วนบุคคลของคุณไปยังประเทศปลายทางนั้นมีมาตรฐานการคุ้มครองข้อมูลส่วนบุคคลอย่างเพียงพอ หรือกรณีอื่น ๆ ตามที่กฎหมายกำหนด
'''),
              Text('ระยะเวลาจัดเก็บข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะเก็บรักษาข้อมูลส่วนบุคคลของคุณไว้ตามระยะเวลาที่จำเป็นในระหว่างที่คุณเป็นลูกค้าหรือมีความสัมพันธ์อยู่กับเราหรือตลอดระยะเวลาที่จำเป็นเพื่อให้บรรลุวัตถุประสงค์ที่เกี่ยวข้องกับนโยบายฉบับนี้ ซึ่งอาจจำเป็นต้องเก็บรักษาไว้ต่อไปภายหลังจากนั้น หากมีกฎหมายกำหนดไว้ เราจะลบ ทำลาย หรือทำให้เป็นข้อมูลที่ไม่สามารถระบุตัวตนของคุณได้ เมื่อหมดความจำเป็นหรือสิ้นสุดระยะเวลาดังกล่าว
'''),
              Text('สิทธิของเจ้าของข้อมูลส่วนบุคคล', style: head),
              Text('''
ภายใต้กฎหมายคุ้มครองข้อมูลส่วนบุคคล คุณมีสิทธิในการดำเนินการดังต่อไปนี้

● สิทธิขอถอนความยินยอม (right to withdraw consent) หากคุณได้ให้ความยินยอม เราจะเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณ ไม่ว่าจะเป็นความยินยอมที่คุณให้ไว้ก่อนวันที่กฎหมายคุ้มครองข้อมูลส่วนบุคคลใช้บังคับหรือหลังจากนั้น คุณมีสิทธิที่จะถอนความยินยอมเมื่อใดก็ได้ตลอดเวลา

● สิทธิขอเข้าถึงข้อมูล (right to access) คุณมีสิทธิขอเข้าถึงข้อมูลส่วนบุคคลของคุณที่อยู่ในความรับผิดชอบของเราและขอให้เราทำสำเนาข้อมูลดังกล่าวให้แก่คุณ รวมถึงขอให้เราเปิดเผยว่าเราได้ข้อมูลส่วนบุคคลของคุณมาได้อย่างไร
● สิทธิขอถ่ายโอนข้อมูล (right to data portability) คุณมีสิทธิขอรับข้อมูลส่วนบุคคลของคุณในกรณีที่เราได้จัดทำข้อมูลส่วนบุคคลนั้นอยู่ในรูปแบบให้สามารถอ่านหรือใช้งานได้ด้วยเครื่องมือหรืออุปกรณ์ที่ทำงานได้โดยอัตโนมัติและสามารถใช้หรือเปิดเผยข้อมูลส่วนบุคคลได้ด้วยวิธีการอัตโนมัติ รวมทั้งมีสิทธิขอให้เราส่งหรือโอนข้อมูลส่วนบุคคลในรูปแบบดังกล่าวไปยังผู้ควบคุมข้อมูลส่วนบุคคลอื่นเมื่อสามารถทำได้ด้วยวิธีการอัตโนมัติ และมีสิทธิขอรับข้อมูลส่วนบุคคลที่เราส่งหรือโอนข้อมูลส่วนบุคคลในรูปแบบดังกล่าวไปยังผู้ควบคุมข้อมูลส่วนบุคคลอื่นโดยตรง เว้นแต่ไม่สามารถดำเนินการได้เพราะเหตุทางเทคนิค
● สิทธิขอคัดค้าน (right to object) คุณมีสิทธิขอคัดค้านการเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณในเวลาใดก็ได้ หากการเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณที่ทำขึ้นเพื่อการดำเนินงานที่จำเป็นภายใต้ประโยชน์โดยชอบด้วยกฎหมายของเราหรือของบุคคลหรือนิติบุคคลอื่น โดยไม่เกินขอบเขตที่คุณสามารถคาดหมายได้อย่างสมเหตุสมผลหรือเพื่อดำเนินการตามภารกิจเพื่อสาธารณประโยชน์
● สิทธิขอให้ลบหรือทำลายข้อมูล (right to erasure/destruction) คุณมีสิทธิขอลบหรือทำลายข้อมูลส่วนบุคคลของคุณหรือทำให้ข้อมูลส่วนบุคคลเป็นข้อมูลที่ไม่สามารถระบุตัวคุณได้ หากคุณเชื่อว่าข้อมูลส่วนบุคคลของคุณถูกเก็บรวบรวม ใช้ หรือเปิดเผยโดยไม่ชอบด้วยกฎหมายที่เกี่ยวข้องหรือเห็นว่าเราหมดความจำเป็นในการเก็บรักษาไว้ตามวัตถุประสงค์ที่เกี่ยวข้องในนโยบายฉบับนี้ หรือเมื่อคุณได้ใช้สิทธิขอถอนความยินยอมหรือใช้สิทธิขอคัดค้านตามที่แจ้งไว้ข้างต้นแล้ว
● สิทธิขอให้ระงับการใช้ข้อมูล (right to restriction of processing) คุณมีสิทธิขอให้ระงับการใช้ข้อมูลส่วนบุคคลชั่วคราวในกรณีที่เราอยู่ระหว่างตรวจสอบตามคำร้องขอใช้สิทธิขอแก้ไขข้อมูลส่วนบุคคลหรือขอคัดค้านของคุณหรือกรณีอื่นใดที่เราหมดความจำเป็นและต้องลบหรือทำลายข้อมูลส่วนบุคคลของคุณตามกฎหมายที่เกี่ยวข้องแต่คุณขอให้เราระงับการใช้แทน
● สิทธิขอให้แก้ไขข้อมูล (right to rectification) คุณมีสิทธิขอแก้ไขข้อมูลส่วนบุคคลของคุณให้ถูกต้อง เป็นปัจจุบัน สมบูรณ์ และไม่ก่อให้เกิดความเข้าใจผิด
● สิทธิร้องเรียน (right to lodge a complaint) คุณมีสิทธิร้องเรียนต่อผู้มีอำนาจตามกฎหมายที่เกี่ยวข้อง หากคุณเชื่อว่าการเก็บรวบรวม ใช้ หรือเปิดเผยข้อมูลส่วนบุคคลของคุณ เป็นการกระทำในลักษณะที่ฝ่าฝืนหรือไม่ปฏิบัติตามกฎหมายที่เกี่ยวข้อง

คุณสามารถใช้สิทธิของคุณในฐานะเจ้าของข้อมูลส่วนบุคคลข้างต้นได้ โดยติดต่อมาที่เจ้าหน้าที่คุ้มครองข้อมูลส่วนบุคคลของเราตามรายละเอียดท้ายนโยบายนี้ เราจะแจ้งผลการดำเนินการภายในระยะเวลา 30 วัน นับแต่วันที่เราได้รับคำขอใช้สิทธิจากคุณ ตามแบบฟอร์มหรือวิธีการที่เรากำหนด ทั้งนี้ หากเราปฏิเสธคำขอเราจะแจ้งเหตุผลของการปฏิเสธให้คุณทราบผ่านช่องทางต่าง ๆ เช่น ข้อความ (SMS) อีเมล โทรศัพท์ จดหมาย เป็นต้น
'''),
              Text('การโฆษณาและการตลาด', style: head),
              Text('''
เราอาจส่งข้อมูลหรือจดหมายข่าวไปยังอีเมลของคุณ โดยมีวัตถุประสงค์เพื่อเสนอสิ่งที่น่าสนกับคุณ หากคุณไม่ต้องการรับการติดต่อสื่อสารจากเราผ่านทางอีเมลอีกต่อไป คุณสามารถกด "ยกเลิกการติดต่อ" ในลิงก์อีเมลหรือติดต่อมายังอีเมลของเราได้
'''),
              Text('การรักษาความมั่งคงปลอดภัยของข้อมูลส่วนบุคคล', style: head),
              Text('''
เราจะรักษาความมั่นคงปลอดภัยของข้อมูลส่วนบุคคลของคุณไว้ตามหลักการ การรักษาความลับ (confidentiality) ความถูกต้องครบถ้วน (integrity) และสภาพพร้อมใช้งาน (availability) ทั้งนี้ เพื่อป้องกันการสูญหาย เข้าถึง ใช้ เปลี่ยนแปลง แก้ไข หรือเปิดเผย นอกจากนี้เราจะจัดให้มีมาตรการรักษาความมั่นคงปลอดภัยของข้อมูลส่วนบุคคล ซึ่งครอบคลุมถึงมาตรการป้องกันด้านการบริหารจัดการ (administrative safeguard) มาตรการป้องกันด้านเทคนิค (technical safeguard) และมาตรการป้องกันทางกายภาพ (physical safeguard) ในเรื่องการเข้าถึงหรือควบคุมการใช้งานข้อมูลส่วนบุคคล (access control)
'''),
              Text('การแจ้งเหตุละเมิดข้อมูลส่วนบุคคล', style: head),
              Text('''
ในกรณีที่มีเหตุละเมิดข้อมูลส่วนบุคคลของคุณเกิดขึ้น เราจะแจ้งให้สำนักงานคณะกรรมการคุ้มครองข้อมูลส่วนบุคคลทราบโดยไม่ชักช้าภายใน 72 ชั่วโมง นับแต่ทราบเหตุเท่าที่สามารถกระทำได้ ในกรณีที่การละเมิดมีความเสี่ยงสูงที่จะมีผลกระทบต่อสิทธิและเสรีภาพของคุณ เราจะแจ้งการละเมิดให้คุณทราบพร้อมกับแนวทางการเยียวยาโดยไม่ชักช้าผ่านช่องทางต่าง ๆ เช่น เว็บไซต์ ข้อความ (SMS) อีเมล โทรศัพท์ จดหมาย เป็นต้น
'''),
              Text('การแก้ไขเปลี่ยนแปลงนโยบายความเป็นส่วนตัว', style: head),
              Text('''
เราอาจแก้ไขเปลี่ยนแปลงนโยบายนี้เป็นครั้งคราว โดยคุณสามารถทราบข้อกำหนดและเงื่อนไขนโยบายที่มีการแก้ไขเปลี่ยนแปลงนี้ได้ผ่านทางเว็บไซต์ของเรา

นโยบายนี้แก้ไขล่าสุดและมีผลใช้บังคับตั้งแต่วันที่ 22 พฤษภาคม 2566
'''),
              Text('นโยบายความเป็นส่วนตัวของเว็บไซต์อื่น', style: head),
              Text('''
นโยบายความเป็นส่วนตัวฉบับนี้ใช้สำหรับการเสนอสินค้า บริการ และการใช้งานบนเว็บไซต์สำหรับลูกค้าของเราเท่านั้น หากคุณเข้าชมเว็บไซต์อื่นแม้จะผ่านช่องทางเว็บไซต์ของเรา การคุ้มครองข้อมูลส่วนบุคคลต่าง ๆ จะเป็นไปตามนโยบายความเป็นส่วนตัวของเว็บไซต์นั้น ซึ่งเราไม่มีส่วนเกี่ยวข้องด้วย
'''),
              Text('รายละเอียดการติดต่อ', style: head),
              Text('''
 หากคุณต้องการสอบถามข้อมูลเกี่ยวกับนโยบายความเป็นส่วนตัวฉบับนี้ รวมถึงการขอใช้สิทธิต่าง ๆ คุณสามารถติดต่อเราหรือเจ้าหน้าที่คุ้มครองข้อมูลส่วนบุคคลของเราได้ ดังนี้
'''),
              Text('ผู้ควบคุมข้อมูลส่วนบุคคล', style: head),
              Text('''

บริษัท คอมพัฒนา จำกัด

369/11 ในเมือง เมืองนครราชสีมา นครราชสีมา 30000

อีเมล weeradach.chinpimai@compattana.com

เว็บไซต์ https://compattana.com/

หมายเลขโทรศัพท์ 0939794636

เจ้าหน้าที่คุ้มครองข้อมูลส่วนบุคคล

อภิชาติ คำจีนสี

369/11 ในเมือง เมืองนครราชสีมา นครราชสีมา 30000

อีเมล apichat.kumjensi@compattana.com

หมายเลขโทรศัพท์ 0929251946
'''),
            ],
          ),
        ),
      ),
    );
  }
}
