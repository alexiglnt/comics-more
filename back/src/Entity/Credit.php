<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\CreditRepository;
use Doctrine\ORM\Mapping as ORM;

use ApiPlatform\Metadata\Post;
use ApiPlatform\Metadata\Put;

#[Post]
#[Put]

#[ApiResource]
#[ORM\Entity(repositoryClass: CreditRepository::class)]
class Credit
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $price = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPrice(): ?int
    {
        return $this->price;
    }

    public function setPrice(int $price): self
    {
        $this->price = $price;

        return $this;
    }
}
