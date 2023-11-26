defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete a key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "key2delete") == nil

    KV.Bucket.put(bucket, "key2delete", "delete")
    assert KV.Bucket.get(bucket, "key2delete") == "delete"

    KV.Bucket.delete(bucket, "key2delete")
    assert KV.Bucket.get(bucket, "key2delete") == nil
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end

end
