RSpec.describe Gringott::Memstore do

  subject { Gringott::Memstore.new }

  it 'implements a get method' do
    expect(subject).to respond_to(:get)
  end

  it 'implements a set method' do
    expect(subject).to respond_to(:set)
  end

  it 'implements a delete method' do
    expect(subject).to respond_to(:delete)
  end

  it 'sets the (key, value) data on the store and gets the data' do
    subject.set("mykey", "myvalue")
    expect(subject.get("mykey")).to eq("myvalue")
  end

  it 'deletes the value set' do
    subject.set("mykey", "myvalue")
    subject.delete("mykey")
    expect(subject.get("mykey")).to be_nil
  end

  it 'responds with nil if the key is not set on store' do
    expect(subject.get("mykey")).to be_nil
  end
end