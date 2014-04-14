class SplatSpec_Mock1 < Java::Lang::Object
  def to_a
    ['foo']
  end
end

class SplatSpec_Mock2 < Java::Lang::Object
  def to_a
    nil
  end
end

describe "Splat operator" do
  describe "used to assign a splatted object to an object" do
    it "assigns an empty array when the splatted object is nil" do
      a = *nil; a.should == []
    end

    it "assigns an empty array when the splatted object is an empty array" do
      a = *[]; a.should == []
    end

    it "assigns the splatted object contained into an array when the splatted object doesn't respond to to_a" do
      a = *1; a.should == [1]
    end

    it "assigns the returned value of to_a when the splatted object responds to to_a" do
      o = SplatSpec_Mock1.new
      a = *o; a.should == ["foo"]
    end

    it "assigns the object in a new array when it responds to to_a but to_a returns nil" do
      o = SplatSpec_Mock2.new
      a = *o; a.should == [o]
    end

    it "assigns an array with nil object if the content of the splatted array is nil" do
      a = *[nil]; a.should == [nil]
    end

    it "assings an array with an empty array when the splatted array contains an empty array" do
      a = *[[]]; a.should == [[]]
    end

    it "assigns an empty array when the content of the splatted array is an empty splatted array" do
      a = *[*[]]; a.should == []
    end

    it "assigns the second array when the content of the splatted array is a non empty splatted array" do
      a = *[*[1]]; a.should == [1]
    end

    it "assigns the second array when the splatted array contains a splatted array with more than one element" do
      a = *[*[1, 2]]; a.should == [1, 2]
    end
  end

  describe "used to assign an object to a splatted reference" do
    it "assigns an array with a nil object when the object is nil" do
      *a = nil; a.should == [nil]
    end

    it "assigns an array containing the object when the object is not an array" do
      *a = 1; a.should == [1]
    end

    it "assigns the object when the object is an array" do
      *a = []; a.should == []
      *a = [1]; a.should == [1]
      *a = [nil]; a.should == [nil]
      *a = [1,2]; a.should == [1,2]
    end

    it "assigns the splatted array when the object is an array that contains an splatted array" do
      *a = [*[]]; a.should == []
      *a = [*[1]]; a.should == [1]
      *a = [*[1,2]]; a.should == [1,2]
    end
  end

  describe "used to assign a splatted object to a splatted reference" do
    it "assigns an empty array when the splatted object is an empty array" do
      *a = *[]; a.should == []
    end

    it "assigns an array containing the splatted object when the splatted object is not an array" do
      *a = *1; a.should == [1]
    end

    it "assigns an array when the splatted object is an array" do
      *a = *[1,2]; a.should == [1,2]
      *a = *[1]; a.should == [1]
      *a = *[nil]; a.should == [nil]
    end

    it "assigns an empty array when the splatted object is an array that contains an empty splatted array" do
      *a = *[*[]]; a.should == []
      *a = *[*[1]]; a.should == [1]
      *a = *[*[1,2]]; a.should == [1,2]
    end

    it "assigns an empty array when the splatted object is nil" do
      *a = *nil; a.should == []
    end
  end

  describe "used to assign splatted objects to multiple block variables" do
    it "assigns nil to normal variables but empty array to references when the splatted object is nil" do
      a,b,*c = *nil; [a,b,c].should == [nil, nil, []]
    end

    it "assigns nil to normal variables but empty array to references when the splatted object is an empty array" do
      a,b,*c = *[]; [a,b,c].should == [nil, nil, []]
    end

    it "assigns the splatted object to the first variable and behaves like nil when the splatted object is not an array" do
      a,b,*c = *1; [a,b,c].should == [1, nil, []]
    end

    it "assigns array values to normal variables but arrays containing elements to references" do
      a,b,*c = *[1,2,3]; [a,b,c].should == [1,2,[3]]
    end

    it "assigns and empty array to the variable if the splatted object contains an empty array" do
      a,b,*c = *[[]]; [a,b,c].should == [[], nil, []]
    end

    it "assigns the values of a splatted array when the splatted object contains an splatted array" do
      a,b,*c = *[*[1,2,3]]; [a,b,c].should == [1,2,[3]]
    end
  end
end
