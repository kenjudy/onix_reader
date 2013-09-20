# encoding: utf-8
require_relative "../../models/book.rb"

describe Book do
  before(:each) do
   Nokogiri::XML::Document.stub(parse: Nokogiri::Slop(onix_sample))
   #Nokogiri::XML::Document.stub(parse: Nokogiri::Slop(File.new('/Users/kenhjudy/dev/onix/xml/onix/simon_us_simon_onix21-2013-0905.xml').read))

  end

  subject(:book) { Book.new(double(File))}
  
  its(:isbn13) { should == '9781476716534' }
  its(:isbn10) { should == '1476716536' }
  its(:title) { should == 'A Great Game'}
  its(:subtitle) { should == 'The Forgotten Leafs & the Rise of Professional Hockey' }
  its(:workkey) { should == '408743661' }
  its(:language) { should == 'English' }
  its(:imprint) { should == 'Simon & Schuster' }
  its(:publisher) { should == 'Simon & Schuster' }
  its(:trim_size) { should include "6.25 x 9.25" }
  its(:format) { should == 'Hardback' }
  its(:sub_format) { should == nil }
  
  it "should have errors for nil values" do
    expect(subject.errors.keys).to eq [:sub_format]
  end

  def onix_sample
    onix = <<XML
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE ONIXmessage SYSTEM "http://www.editeur.org/onix/2.1/short/onix-international.dtd">
<ONIXmessage release="2.1">
  <header>
    <m174>Simon &amp; Schuster</m174>
    <m175>Catherine Toolan 978-465-7755</m175>
    <m283>eloquence@firebrandtech.com</m283>
    <m182>20130905</m182>
    <m183>Title information from Simon &amp; Schuster</m183>
    <m184>eng</m184>
    <m185>01</m185>
    <m186>USD</m186>
    <m187>in</m187>
    <m193>General Trade</m193>
  </header>
  <product>
    <a001>1476716536</a001>
    <a002>02</a002>
    <productidentifier>
      <b221>02</b221>
      <b244>1476716536</b244>
    </productidentifier>
    <productidentifier>
      <b221>03</b221>
      <b244>9781476716534</b244>
    </productidentifier>
    <productidentifier>
      <b221>15</b221>
      <b244>9781476716534</b244>
    </productidentifier>
    <b246>11</b246>
    <b012>BB</b012>
    <productformfeature>
      <b334>30</b334>
    </productformfeature>
    <n338/>
    <title>
      <b202>01</b202>
      <b203>A Great Game</b203>
      <b030>A</b030>
      <b031>Great Game</b031>
      <b029>The Forgotten Leafs &amp; the Rise of Professional Hockey</b029>
    </title>
    <workidentifier>
      <b201>01</b201>
      <b244>408743661</b244>
    </workidentifier>
    <contributor>
      <b034>1</b034>
      <b035>A01</b035>
      <b036>Stephen J. Harper</b036>
      <b037>Harper, Stephen J.</b037>
      <b039>Stephen J.</b039>
      <b040>Harper</b040>
      <b044>Like millions of other Canadians, Stephen Harper developed his love for hockey at a young age as he played at the arenas and on the shinny rinks and roads of his hometown. &amp;nbsp;Today, long retired from his on-ice “career” with the Leaside Lions, he is the 22nd Prime Minister of Canada and is happily married to Laureen, who, with their children Ben and Rachel, live in Calgary and Ottawa. A member of the Society of International Hockey Research with a particular interest in the early decades of the game, Mr. Harper is an amateur historian interested in exploring the sport’s impact on the people and places that define Canada. &lt;i&gt;A Great Game&lt;/i&gt; is his first published work on the game of hockey.</b044>
    </contributor>
    <b049>Stephen J. Harper</b049>
    <n386/>
    <language>
      <b253>01</b253>
      <b252>eng</b252>
    </language>
    <b061>368</b061>
    <b062>rough front, 2 8-pp 4-c inserts, 124 b-w photos t-o</b062>
    <b064>HIS006000</b064>
    <subject>
      <b067>10</b067>
      <b069>SPO019000</b069>
    </subject>
    <subject>
      <b067>10</b067>
      <b069>SPO020000</b069>
    </subject>
    <audience>
      <b204>01</b204>
      <b206>01</b206>
    </audience>
    <othertext>
      <d102>01</d102>
      <d103>02</d103>
      <d104>Drawing on extensive archival records and illustrations, histories of the sport, and newspaper files, Canada’s Prime Minister delves into the fascinating early years of ice hockey.&lt;p&gt;In the tumultuous beginnings of hockey, the fights were as much off the ice as on it. This engaging new book is about the hockey heroes and hard-boiled businessmen who built the game, and the rise and fall of legendary teams pursuing the Stanley Cup. With a historian’s perspective and fan’s passion, Stephen Harper presents a riveting and often-surprising portrait, capturing everything from the physical contests on the rinks to the battles behind the scenes.&lt;BR&gt;&lt;BR&gt;Stephen Harper shows that many things have stayed the same. Rough play, fervent hometown loyalties, owner-player contract disputes, dubious news coverage, and big money were issues from the get-go. Most important in these early years was the question: Was hockey to be a game of obsessed amateurs playing for the love of the sport, or was it a game for paid professionals who would give fans what they wanted? Who should be responsible for the sport—including its bouts of violence—both on and off the ice.&lt;BR&gt;&lt;BR&gt;A century ago, rinks could melt, and by halftime the blades screwed to the players’ shoes could be sinking in mud. It was during this time that the unsuccessful Toronto Professionals of 1908 and the victorious Toronto Blue Shirts of 1914 battled for the city’s very first Stanley Cup. Against the fanatical opposition of amateur hockey leaders, these “forgotten Leafs” would lay the groundwork for the world’s most profitable hockey franchise.&lt;BR&gt;&lt;BR&gt;In paying tribute to these hockey pioneers and the contagious loyalty of their fans, Harper resurrects the history of hockey’s first decades. Lavishly illustrated with photographs of the game’s greatest arenas and earliest star players, this entertaining and original book will captivate you from start to finish.</d104>
    </othertext>
    <othertext>
      <d102>13</d102>
      <d103>02</d103>
      <d104>Like millions of other Canadians, Stephen Harper developed his love for hockey at a young age as he played at the arenas and on the shinny rinks and roads of his hometown. Today, long retired from his on-ice “career” with the Leaside Lions, he is the 22nd Prime Minister of Canada and is happily married to Laureen, who, with their children Ben and Rachel, live in Calgary and Ottawa.&lt;BR&gt; &lt;BR&gt;A member of the Society of International Hockey Research with a particular interest in the early decades of the game, Mr. Harper is an amateur historian interested in exploring the sport’s impact on the people and places that define Canada.&lt;BR&gt; &lt;BR&gt;&lt;I &gt;A Great Game&lt;/I&gt; is his first published work on the game of hockey.</d104>
    </othertext>
    <imprint>
      <b241>01</b241>
      <b242>Simon &amp; Schuster</b242>
      <b243>SIMO001</b243>
      <b079>Simon &amp; Schuster</b079>
    </imprint>
    <publisher>
      <b291>01</b291>
      <b241>01</b241>
      <b242>Simon &amp; Schuster</b242>
      <b243>SIMO001</b243>
      <b081>Simon &amp; Schuster</b081>
    </publisher>
    <b394>02</b394>
    <b003>20131105</b003>
    <salesrights>
      <b089>01</b089>
      <b090>AD AE AF AG AI AL AM AO AQ AR AS AT AU AW AX AZ BA BB BD BE BF BG BH BI BJ BL BM BN BO BQ BR BS BT BV BW BY BZ CA CC CD CF CG CH CI CK CL CM CN CO CR CU CV CW CX CY CZ DE DJ DK DM DO DZ EC EE EG EH ER ES ET FI FJ FK FM FO FR GA GB GD GE GF GG GH GI GL GM GN GP GQ GR GS GT GU GW GY HK HM HN HR HT HU ID IE IL IM IN IO IQ IR IS IT JE JM JO JP KE KG KH KI KM KN KP KR KW KY KZ LA LB LC LI LK LR LS LT LU LV LY MA MC MD ME MF MG MH MK ML MM MN MO MP MQ MR MS MT MU MV MW MX MY MZ NA NC NE NF NG NI NL NO NP NR NU NZ OM PA PE PF PG PH PK PL PM PN PR PS PT PW PY QA RE RO RS RU RW SA SB SC SD SE SG SH SI SJ SK SL SM SN SO SR SS ST SV SX SY SZ TC TD TF TG TH TJ TK TL TM TN TO TR TT TV TW TZ UA UG UM US UY UZ VA VC VE VG VI VN VU WF WS YE YT ZA ZM ZW</b090>
    </salesrights>
    <measure>
      <c093>01</c093>
      <c094>9.25</c094>
      <c095>in</c095>
    </measure>
    <measure>
      <c093>01</c093>
      <c094>234.95</c094>
      <c095>mm</c095>
    </measure>
    <measure>
      <c093>02</c093>
      <c094>6.25</c094>
      <c095>in</c095>
    </measure>
    <measure>
      <c093>02</c093>
      <c094>158.75</c094>
      <c095>mm</c095>
    </measure>
    <relatedproduct>
      <h208>27</h208>
      <productidentifier>
        <b221>15</b221>
        <b244>9781476716558</b244>
      </productidentifier>
    </relatedproduct>
    <supplydetail>
      <j137>Simon &amp; Schuster</j137>
      <j268>02</j268>
      <j269>Y</j269>
      <j141>NP</j141>
      <j396>10</j396>
      <j142>20131014</j142>
      <j143>20131105</j143>
      <j145>20</j145>
      <price>
        <j148>01</j148>
        <discountcoded>
          <j363>02</j363>
          <j364>001</j364>
        </discountcoded>
        <j151>34.99</j151>
        <j152>USD</j152>
        <j161>20130905</j161>
      </price>
    </supplydetail>
  </product>
</ONIXmessage>
XML
  end
end