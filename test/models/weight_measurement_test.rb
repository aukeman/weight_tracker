require 'test_helper'

class WeightMeasurementTest < ActiveSupport::TestCase

  test 'valid weight measurement' do
    wm = WeightMeasurement.create day: 17197, weight: 150.0, user: users(:user1)
    puts wm.errors.full_messages
    assert wm.valid?
  end

  test "weight must not be 0" do
    wm = WeightMeasurement.create day: 17197, weight: 0, user: users(:user1)
    refute wm.valid?
    refute wm.errors[:weight].nil?
  end

  test "weight must not be negative" do
    wm = WeightMeasurement.create day: 17197, weight: -1, user: users(:user1)
    refute wm.valid?
    refute wm.errors[:weight].nil?
  end

  test "weight may be fractional" do
    wm = WeightMeasurement.create day: 17197, weight: 150.5, user: users(:user1)
    assert wm.valid?
  end

  test "day must not be 0" do
    wm = WeightMeasurement.create day: 0, weight: 150.0, user: users(:user1)
    refute wm.valid?
    refute wm.errors[:day].nil?
  end

  test "day must not be negative" do
    wm = WeightMeasurement.create day: -1, weight: 150.0, user: users(:user1)
    refute wm.valid?
    refute wm.errors[:day].nil?
  end

  test "day must be an integer" do
    wm = WeightMeasurement.create day: 17197.5, weight: 150.0, user: users(:user1)
    refute wm.valid?
    refute wm.errors[:day].nil?
  end

  test "day must be unique within a user" do
    wm1 = WeightMeasurement.create day: 17197, weight: 150.0, user: users(:user1)
    wm2 = WeightMeasurement.create day: 17197, weight: 150.0, user: users(:user1)

    assert wm1.valid?
    
    refute wm2.valid?
    refute wm2.errors[:day].nil?
  end

  test "different users may have measuremetns on the same day" do
    wm1 = WeightMeasurement.create day: 17197, weight: 150.0, user: users(:user1)
    wm2 = WeightMeasurement.create day: 17197, weight: 150.0, user: users(:user2)

    assert wm1.valid?
    assert wm2.valid?
  end

  test "must be associated with a user" do
    wm = WeightMeasurement.create day: 17197, weight: 150.0, user: nil
    refute wm.valid?
    refute wm.errors[:user].nil?
  end



end
