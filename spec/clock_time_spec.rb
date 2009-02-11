require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'Time with clock_time' do
  before do
    now = Time.now
    Time.stub!(:now).and_return(now) # freeze now for tests
  end
  
  it "Time.tomorrow should == Time.now + 1.day" do
    Time.tomorrow.should == Time.now + 1.day
  end

  it "Time.yesterday should == Time.now - 1.day" do
    Time.yesterday.should == Time.now - 1.day
  end
  
  describe "A time object" do
    before do
      @time = Time.now
    end
    
    it "#at_12am should == time.at_beginning_of_day" do
      @time.at_12am.should == @time.at_beginning_of_day
    end
    
    it "#at_12pm should == time.at_beginning_of_day + 12 hours" do
      @time.at_12pm.should == @time.at_beginning_of_day + 12.hours
    end
    
    it "#at_1am should == time.at_beginning_of_day + 1 hours" do
      @time.at_1am.should == @time.at_beginning_of_day + 1.hours
    end
    
    it "#at_1pm should == time.at_beginning_of_day + 13 hours" do
      @time.at_1pm.should == @time.at_beginning_of_day + 13.hours
    end
    
    it "should not respond to at_0am" do
      @time.should_not respond_to("at_0am")
    end

    it "should not respond to at_13am" do
      @time.should_not respond_to("at_13am")
    end
    
    it "#at_0000 should == time.at_beginning_of_day" do
      @time.at_0000.should == @time.at_beginning_of_day
    end
    
    it "#at_1200 should == time.at_beginning_of_day + 12 hours" do
      @time.at_1200.should == @time.at_beginning_of_day + 12.hours
    end
    
    it "#at_0100 should == time.at_beginning_of_day + 1 hours" do
      @time.at_0100.should == @time.at_beginning_of_day + 1.hours
    end
    
    it "#at_1300 should == time.at_beginning_of_day + 13 hours" do
      @time.at_1300.should == @time.at_beginning_of_day + 13.hours
    end
    
    it "#at_2120 should == time.at_beginning_of_day + 21 hours + 20.minutes" do
      @time.at_2120.should == @time.at_beginning_of_day + 21.hours + 20.minutes
    end
    
    it "#at_2120 should == time.at_beginning_of_day + 21 hours + 20.minutes" do
      @time.at_2120.should == @time.at_beginning_of_day + 21.hours + 20.minutes
    end

    it "should not respond to at_000" do
      @time.should_not respond_to("at_000")
    end

    it "should not respond to at_2400" do
      @time.should_not respond_to("at_2400")
    end

    it "should not respond to at_0060" do
      @time.should_not respond_to("at_0060")
    end
  end
end