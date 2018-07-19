require 'watirspec_helper'

describe Watir::Element do

  describe '#present?' do
    before do
      browser.goto(WatirSpec.url_for("wait.html"))
    end

    it 'returns true if the element exists and is visible' do
      expect(browser.div(:id, 'foo')).to be_present
    end

    it 'returns false if the element exists but is not visible' do
      expect(browser.div(:id, 'bar')).to_not be_present
    end

    it 'returns false if the element does not exist' do
      expect(browser.div(:id, 'should-not-exist')).to_not be_present
    end

    it "returns false if the element is stale" do
      element = browser.div(id: "foo").tap(&:exists?)

      browser.refresh

      expect(element).to be_stale
      expect(element).to_not be_present
    end

  end

  describe "#enabled?" do
    before do
      browser.goto(WatirSpec.url_for("forms_with_input_elements.html"))
    end

    it "returns true if the element is enabled" do
      expect(browser.element(name: 'new_user_submit')).to be_enabled
    end

    it "returns false if the element is disabled" do
      expect(browser.element(name: 'new_user_submit_disabled')).to_not be_enabled
    end

    it "raises UnknownObjectException if the element doesn't exist" do
      expect { browser.element(name: "no_such_name").enabled? }.to raise_unknown_object_exception
    end
  end

  describe "#exists?" do
    before do
      browser.goto WatirSpec.url_for('removed_element.html')
    end

    it "element from a collection returns false when it becomes stale" do
      element = browser.divs(id: "text").first.tap(&:exists?)

      browser.refresh

      expect(element).to be_stale
      expect(element).to_not exist
    end

    it "returns false when tag name does not match id" do
      watir_element = browser.span(id: "text")
      expect(watir_element).to_not exist
    end
  end

  describe "#element_call" do

    it 'handles exceptions when taking an action on a stale element' do
      browser.goto WatirSpec.url_for('removed_element.html')

      element = browser.div(id: "text").tap(&:exists?)

      browser.refresh

      expect(element).to be_stale
      expect { element.text }.to_not raise_error
    end

  end

  describe "#hover" do
    not_compliant_on :internet_explorer, :safari do
      it "should hover over the element" do
        browser.goto WatirSpec.url_for('hover.html')
        link = browser.a

        expect(link.style("font-size")).to eq "10px"
        link.hover
        link.wait_until { |l| l.style("font-size") == "20px" }
        expect(link.style("font-size")).to eq "20px"
      end
    end
  end

  describe "#inspect" do
    before(:each) { browser.goto(WatirSpec.url_for("nested_iframes.html")) }

    it "does displays specified element type" do
      expect(browser.div.inspect).to include('Watir::Div')
    end

    it "does not display element type if not specified" do
      element = browser.element(index: 4)
      expect(element.inspect).to include('Watir::HTMLElement')
    end

    it "displays keyword if specified" do
      element = browser.h3
      element.keyword = 'foo'
      expect(element.inspect).to include('keyword: foo')
    end

    it "does not display keyword if not specified" do
      element = browser.h3
      expect(element.inspect).to_not include('keyword')
    end

    it "locate is false when not located" do
      element = browser.div(:id, 'not_present')
      expect(element.inspect).to include('located: false')
    end

    it "locate is true when located" do
      element = browser.h3
      element.exists?
      expect(element.inspect).to include('located: true')
    end

    it "displays selector string for element from colection" do
      elements = browser.frames
      expect(elements.last.inspect).to include '{:tag_name=>"frame", :index=>-1}'
    end

    it "displays selector string for nested element" do
      browser.goto(WatirSpec.url_for("wait.html"))
      element = browser.div(index: 1).div(id: 'div2')
      expect(element.inspect).to include '{:index=>1, :tag_name=>"div"} --> {:id=>"div2", :tag_name=>"div"}'
    end

    it "displays selector string for nested element under frame" do
      element = browser.iframe(id: 'one').iframe(id: 'three')
      expect(element.inspect).to include '{:id=>"one", :tag_name=>"iframe"} --> {:id=>"three", :tag_name=>"iframe"}'
    end
  end
end
