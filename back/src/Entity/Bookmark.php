<?php

namespace App\Entity;

use ApiPlatform\Metadata\ApiResource;
use App\Repository\BookmarkRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BookmarkRepository::class)]
#[ApiResource]
class Bookmark
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column]
    private ?int $userID = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $comicsId = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUserID(): ?int
    {
        return $this->userID;
    }

    public function setUserID(int $userID): self
    {
        $this->userID = $userID;

        return $this;
    }

    public function getComicsId(): ?string
    {
        return $this->comicsId;
    }

    public function setComicsId(?string $comicsId): self
    {
        $this->comicsId = $comicsId;

        return $this;
    }
}
