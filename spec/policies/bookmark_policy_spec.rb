require 'spec_helper'

describe BookmarkPolicy do
  subject { BookmarkPolicy.new(user, bookmark) }

  let(:test_user) { User.create(email: "test@test.org", password: "testme") }
  let(:bookmark) { Bookmark.create(title: "test", address: "test", user: test_user) }

  context "for a visitor" do
    let(:user) { nil }

    it { should     permit(:show)    }

    it { should_not permit(:create)  }
    it { should_not permit(:new)     }
    it { should_not permit(:update)  }
    it { should_not permit(:edit)    }
    it { should_not permit(:destroy) }
  end

  context "for a user" do
    let(:user) { test_user }

    it { should permit(:show)    }
    it { should permit(:create)  }
    it { should permit(:new)     }
    it { should permit(:update)  }
    it { should permit(:edit)    }
    it { should permit(:destroy) }
  end
end
