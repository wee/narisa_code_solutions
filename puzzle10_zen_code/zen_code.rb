class Node
  TAB_SIZE = 2
  
  def initialize(name)
    @name, @attributes, @children = name, [], []
  end
  
  def add_attribute(name, value)
    @attributes << [name, value]
  end
  
  def add_child(node)
    @children << node
  end
  
  def to_s
    to_string(0)
  end
  
  protected
  def to_string(level)
    tabs = ' ' * (level * TAB_SIZE)
    children = @children.map { |child| child.to_string(level+1) }.join("\n").to_s
    children = "\n#{children}\n#{tabs}" unless children.empty?
    "#{tabs}<#{@name}#{attributes}>#{children}</#{@name}>"
  end
  
  private
  def attributes
    return "" if @attributes.empty?
    " " + @attributes.map { |name, value| %[#{name}="#{value}"] }.join(' ')
  end
  
end

class Parser
  CSS_MAPPING = { "#" => "id", "." => "class" }
  
  def parse(string)
    node_string, children_string = string.split(/>/, 2)
    current_node_string, number_of_times = node_string.split "*"
    node = parse_node(current_node_string)
    parse_children(children_string) { |child| node.add_child(child) }
    Array.new((number_of_times || "1").to_i, node)
  end

  private
  
  def parse_node(string)
    tag_name, *attributes = string.split /#|\./
    node = Node.new(tag_name)
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
      parse(child).each { |node| yield node }
    end
  end
end

require 'test/unit'

class ZenCodeTest < Test::Unit::TestCase
  def test_tag
    assert_equal '<div></div>', Parser.new.parse("div").to_s
  end

  def test_tag_with_id_attribute
    assert_equal '<div id="content"></div>', Parser.new.parse("div#content").to_s
  end

  def test_tag_with_class_attribute
    assert_equal '<div class="class_name"></div>', 
                 Parser.new.parse("div.class_name").to_s
  end

  def test_tag_with_id_and_class_attributes
    assert_equal '<div id="id_name" class="class_name"></div>', 
                 Parser.new.parse("div#id_name.class_name").to_s
  end
  
  def test_tag_with_a_child
    expected = "<div>\n  <h1></h1>\n</div>"
    assert_equal expected, Parser.new.parse("div>h1").to_s
  end
  
  def test_tag_with_grand_child
    expected = "<div>\n  <ul>\n    <li></li>\n  </ul>\n</div>"
    assert_equal expected, Parser.new.parse("div>ul>li").to_s
  end
  
  def test_tag_with_children
    expected = "<div>\n  <h1></h1>\n  <p></p>\n</div>"
    assert_equal expected, Parser.new.parse("div>h1+p").to_s
  end
  
  def test_tag_with_attributes_and_children
    expected = %[<div id="content">\n  <h1></h1>\n  <p></p>\n</div>]
    assert_equal expected, Parser.new.parse("div#content>h1+p").to_s
  end
  
  def test_tag_with_multiples
    expected = <<-eos
<div id="page">
  <div class="logo"></div>
  <ul id="navigation">
    <li></li>
    <li></li>
  </ul>
</div>
eos
    assert_equal expected.chomp, 
                 Parser.new.parse("div#page>div.logo+ul#navigation>li*2").to_s
  end
  
  def test_complex_tag
    expected = <<-eos
<div id="page">
  <div class="logo"></div>
  <ul id="navigation">
    <li>
      <a></a>
    </li>
    <li>
      <a></a>
    </li>
    <li>
      <a></a>
    </li>
    <li>
      <a></a>
    </li>
    <li>
      <a></a>
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

