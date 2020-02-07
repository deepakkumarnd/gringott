RSpec.describe Gringott::Vault do
  
  before do
    allow(Dir).to receive(:exist?).and_return(true)
    @vault = Gringott::Vault.new('myvault')
  end

  subject { @vault }

  it 'initializes a Vault object' do
    expect(Gringott::Vault.new("myvault")).to be_a(Gringott::Vault)
  end

  it 'should have a vault_name' do
    expect(subject.vault_name).to eq('myvault')
  end

  it 'should set the value of a key' do
    expect(subject.set("age", 20)).to eq('OK')
  end

  it 'should return nil of the key does not exist' do
    expect(subject.get("school")).to be_nil
  end

  it 'should get the vault of the key' do
    # integer
    subject.set("age", 20)
    expect(subject.get("age")).to eq(20)
    # string
    subject.set("fullname", "Harry Potter")
    expect(subject.get("fullname")).to eq("Harry Potter")
  end

  it 'deletes the key stored in the vault' do
    subject.set("age", 20)
    subject.delete("age")
    expect(subject.get("age")).to be_nil
  end

  it 'increment/decrement the key_count on setting and on deletion' do
    subject.set("fullname", 'Harry Potter')
    subject.set("age", 20)
    expect(subject.key_count).to eq(2)
    subject.delete("age")
    expect(subject.key_count).to eq(1)
  end

  it 'On setting the key two times does not increment the key count' do
    subject.set("fullname", 'Harry Potter')
    subject.set("fullname", 'Harry Potter')
    expect(subject.key_count).to eq(1)
  end

  it 'On deleting the key two times does not decrement the key count' do
    subject.set("fullname", 'Harry Potter')
    subject.delete("fullname")
    subject.delete("fullname")
    expect(subject.key_count).to eq(0)
  end

  it 'returns the size of the memstore' do
    expect(subject.bytes_in_memory).to be > 0
  end
end