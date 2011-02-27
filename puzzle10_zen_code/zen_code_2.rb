require 'rexml/document'
class Parser
  CSS_MAPPING = { "#" => "id", "." => "class" }
  
  def parse(string, result = '')
    REXML::Formatters::Pretty.new.write parse_string(string).first, result
    result
  end

  private
  
  def parse_string(string)
    node_string, children_string = string.split(/>/, 2)
    current_node_string, number_of_times = node_string.split "*"
    node = parse_node(current_node_string)
    parse_children(children_string) { |child| node.add_element(child) }
    Array.new((number_of_times || "1").to_i, node)
  end

  def parse_node(string)
    tag_name, *attributes = string.split /#|\./
    node = REXML::Element.new tag_name
    if !attributes.empty?
      symbols = string.split /[^#|\.]*/
      attribute_codes = symbols[1..-1]
      attributes.each_with_index do |attribute, index|
        node.add_attribute(CSS_MAPPING[attribute_codes[index]], attribute)
      end
    end
    node
  end
  
  def parse_children(string)
    return unless string
    string.split("+").each do |child| 
      parse_string(child).each { |node| yield node }
    end
  end
end

require 'test/unit'

class ZenCodeTest < Test::Unit::TestCase
  def test_tag
    assert_equal '<div/>', Parser.new.parse("div").to_s
  end

  def test_tag_with_id_attribute
    assert_equal %[<div id='content'/>], Parser.new.parse("div#content").to_s
  end

  def test_tag_with_class_attribute
    assert_equal %[<div class='class_name'/>],
                 Parser.new.parse("div.class_name").to_s
  end

  def test_tag_with_id_and_class_attributes
    assert_equal %[<div id='id_name' class='class_name'/>],
                 Parser.new.parse("div#id_name.class_name").to_s
  end
  
  def test_tag_with_a_child
    expected = "<div>\n  <h1/>\n</div>"
    assert_equal expected, Parser.new.parse("div>h1").to_s
  end
  
  def test_tag_with_grand_child
    expected = "<div>\n  <ul>\n    <li/>\n  </ul>\n</div>"
    assert_equal expected, Parser.new.parse("div>ul>li").to_s
  end
  
  def test_tag_with_children
    expected = "<div>\n  <h1/>\n  <p/>\n</div>"
    assert_equal expected, Parser.new.parse("div>h1+p").to_s
  end
  
  def test_tag_with_attributes_and_children
    expected = %[<div id='content'>\n  <h1/>\n  <p/>\n</div>]
    assert_equal expected, Parser.new.parse("div#content>h1+p").to_s
  end
  
  def test_tag_with_multiples
    expected = <<-eos
<div id='page'>
  <div class='logo'/>
  <ul id='navigation'>
    <li/>
    <li/>
  </ul>
</div>
eos
    assert_equal expected.chomp, 
                 Parser.new.parse("div#page>div.logo+ul#navigation>li*2").to_s
  end
  
  def test_complex_tag
    expected = <<-eos
<div id='page'>
  <div class='logo'/>
  <ul id='navigation'>
    <li>
      <a/>
    </li>
    <li>
      <a/>
    </li>
    <li>
      <a/>
    </li>
    <li>
      <a/>
    </li>
    <li>
      <a/>
    </li>
  </ul>
</div>
eos
    assert_equal expected.chomp, 
                 Parser.new.parse("div#page>div.logo+ul#navigation>li*5>a").to_s
  end
end

require 'test/unit/ui/console/testrunner'
Test::Unit::UI::Console::TestRunner.run(ZenCodeTest)

