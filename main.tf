provider "google" {
  credentials = file("/home/thsehdrl94/test/jenkins-sa.json")
  project     = "test-project2-394700"
  region      = "asia-northeast3"  # 원하는 리전으로 변경
}

resource "google_compute_instance" "default" {
  name         = "terraform"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast3-a"  # 원하는 존으로 변경

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"  # 사용할 이미지
    }
  }

  network_interface {
    network = "default"
  }
}
